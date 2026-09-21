import 'package:avora/features/groups/domain/entities/group_list_entity.dart';

sealed class GroupsState {
  const GroupsState();
}

class GroupsInitial extends GroupsState {
  const GroupsInitial();
}

class GroupsLoading extends GroupsState {
  const GroupsLoading();
}

class GroupsLoaded extends GroupsState {
  const GroupsLoaded({
    required this.groups,
  });

  final List<GroupListItemEntity> groups;
}

class GroupsFailure extends GroupsState {
  const GroupsFailure({
    required this.message,
  });

  final String message;
}