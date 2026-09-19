import 'package:avora/features/groups/data/params/create_group_params.dart';
import 'package:avora/features/groups/domain/use_case/create_group.dart';
import 'package:avora/features/groups/domain/use_case/update_group_avatar.dart';
import 'package:avora/features/groups/domain/use_case/upload_group_avatar.dart';
import 'package:avora/features/groups/presentation/cubits/create_group/create_group_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit({
    required this.createGroupUseCase,
    required this.updateGroupAvatarUseCase,
    required this.uploadGroupAvatarUseCase,
  }) : super(const CreateGroupInitial());

  final CreateGroupUseCase createGroupUseCase;
  final UpdateGroupAvatarUseCase updateGroupAvatarUseCase;
  final UploadGroupAvatarUseCase uploadGroupAvatarUseCase;

  Future<void> createGroup({
    required String name,
    required List<String> memberIds,
    String? avatarFilePath,
  }) async {
    if (name.trim().isEmpty) return;
    if (memberIds.isEmpty) return;

    emit(const CreateGroupLoading());

    final createResult = await createGroupUseCase(
      params: CreateGroupParams(name: name.trim(), memberIds: memberIds),
    );

    await createResult.fold(
      (failure) async {
        emit(CreateGroupFailure(failure: failure));
      },
      (conversationId) async {
        if (avatarFilePath != null) {
          final uploadResult = await uploadGroupAvatarUseCase(
            conversationId: conversationId,
            filePath: avatarFilePath,
          );

          final uploadFailed = uploadResult.fold((_) => true, (_) => false);

          if (uploadFailed) {
            // Group already exists.
            // We can still continue with the default group avatar.
            emit(CreateGroupSuccess(conversationId: conversationId));
            return;
          }

          final avatarPath = uploadResult.getOrElse(() => '');

          final updateResult = await updateGroupAvatarUseCase(
            conversationId: conversationId,
            avatarUrl: avatarPath,
          );

          updateResult.fold(
            (failure) {
              // Group exists, but avatar update failed.
              emit(CreateGroupSuccess(conversationId: conversationId));
            },
            (_) {
              emit(CreateGroupSuccess(conversationId: conversationId));
            },
          );
        } else {
          emit(CreateGroupSuccess(conversationId: conversationId));
        }
      },
    );
  }
}
