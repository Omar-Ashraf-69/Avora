import 'package:avora/features/groups/data/params/create_group_params.dart';
import 'package:avora/features/groups/domain/use_case/create_group.dart';
import 'package:avora/features/groups/presentation/cubits/create_group/cubit/create_group_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit({
    required this.createGroupUseCase,
  }) : super(const CreateGroupInitial());

  final CreateGroupUseCase createGroupUseCase;

  Future<void> createGroup({
    required String name,
    required List<String> memberIds,
  }) async {
    if (name.trim().isEmpty) return;

    if (memberIds.isEmpty) return;

    emit(const CreateGroupLoading());

    final result = await createGroupUseCase(
      params: CreateGroupParams(
        name: name.trim(),
        memberIds: memberIds,
      ),
    );

    result.fold(
      (failure) {
        emit(
          CreateGroupFailure(
            failure: failure,
          ),
        );
      },
      (conversationId) {
        emit(
          CreateGroupSuccess(
            conversationId: conversationId,
          ),
        );
      },
    );
  }
}