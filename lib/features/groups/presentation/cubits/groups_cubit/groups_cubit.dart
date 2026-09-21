import 'package:avora/features/groups/domain/use_case/get_groups_use_case.dart';
import 'package:avora/features/groups/presentation/cubits/groups_cubit/groups_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit({
    required this.getGroupsUseCase,
  }) : super(const GroupsInitial());

  final GetGroupsUseCase getGroupsUseCase;

  Future<void> loadGroups() async {
    emit(const GroupsLoading());

    final result = await getGroupsUseCase();

    result.fold(
      (failure) {
        emit(
          GroupsFailure(
            message: failure.message,
          ),
        );
      },
      (groups) {
        emit(
          GroupsLoaded(
            groups: groups,
          ),
        );
      },
    );
  }
}