import 'package:avora/features/groups/data/params/create_group_params.dart';
import 'package:avora/features/groups/domain/use_case/create_group.dart';
import 'package:avora/features/groups/domain/use_case/finalize_group_creation.dart';
import 'package:avora/features/groups/domain/use_case/update_group_avatar.dart';
import 'package:avora/features/groups/domain/use_case/upload_group_avatar.dart';
import 'package:avora/features/groups/presentation/cubits/create_group/create_group_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit({
    required this.createGroupUseCase,
    required this.updateGroupAvatarUseCase,
    required this.uploadGroupAvatarUseCase, required this.finalizeGroupCreationUseCase,
  }) : super(const CreateGroupInitial());

  final CreateGroupUseCase createGroupUseCase;
  final UpdateGroupAvatarUseCase updateGroupAvatarUseCase;
  final UploadGroupAvatarUseCase uploadGroupAvatarUseCase;
  final FinalizeGroupCreationUseCase  finalizeGroupCreationUseCase;
  Future<void> createGroup({
  required String name,
  required List<String> memberIds,
  String? avatarFilePath,
}) async {
  if (name.trim().isEmpty) return;
  if (memberIds.isEmpty) return;

  emit(const CreateGroupLoading());

  final createResult = await createGroupUseCase(
    params: CreateGroupParams(
      name: name.trim(),
      memberIds: memberIds,
    ),
  );

  await createResult.fold(
    (failure) async {
      emit(
        CreateGroupFailure(
          failure: failure,
        ),
      );
    },
    (conversationId) async {
      /*
       * --------------------------------------------------
       * STEP 1
       * --------------------------------------------------
       * The group and creator membership now exist.
       *
       * The selected users have NOT been added yet.
       */

      if (avatarFilePath != null) {
        final uploadResult = await uploadGroupAvatarUseCase(
          conversationId: conversationId,
          filePath: avatarFilePath,
        );

        await uploadResult.fold(
          (failure) async {
            /*
             * Avatar upload failed.
             *
             * We still finalize the group so the members
             * can receive the group.
             */
            await _finalizeGroup(
              conversationId: conversationId,
              memberIds: memberIds,
            );
          },
          (avatarPath) async {
            /*
             * --------------------------------------------------
             * STEP 2
             * --------------------------------------------------
             * Avatar has been uploaded.
             *
             * Now update groups.avatar_url.
             */
            final updateResult =
                await updateGroupAvatarUseCase(
              conversationId: conversationId,
              avatarUrl: avatarPath,
            );

            await updateResult.fold(
              (failure) async {
                /*
                 * Avatar metadata update failed.
                 *
                 * Still finalize the group so creation
                 * does not get stuck.
                 */
                await _finalizeGroup(
                  conversationId: conversationId,
                  memberIds: memberIds,
                );
              },
              (_) async {
                /*
                 * --------------------------------------------------
                 * STEP 3
                 * --------------------------------------------------
                 * Avatar is now ready.
                 *
                 * Only NOW do we add the other members.
                 */
                await _finalizeGroup(
                  conversationId: conversationId,
                  memberIds: memberIds,
                );
              },
            );
          },
        );
      } else {
        /*
         * No avatar was selected.
         *
         * The group is already ready, so finalize immediately.
         */
        await _finalizeGroup(
          conversationId: conversationId,
          memberIds: memberIds,
        );
      }
    },
  );
}Future<void> _finalizeGroup({
  required String conversationId,
  required List<String> memberIds,
}) async {
  final result = await finalizeGroupCreationUseCase(
    conversationId: conversationId,
    memberIds: memberIds,
  );

  result.fold(
    (failure) {
      emit(
        CreateGroupFailure(
          failure: failure,
        ),
      );
    },
    (_) {
      emit(
        CreateGroupSuccess(
          conversationId: conversationId,
        ),
      );
    },
  );
}
}
