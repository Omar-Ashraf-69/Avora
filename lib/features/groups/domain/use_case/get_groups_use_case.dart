import 'package:avora/core/error/failures.dart';
import 'package:avora/features/groups/domain/entities/group_list_entity.dart';
import 'package:avora/features/groups/domain/repos/group_repo.dart';
import 'package:dartz/dartz.dart';

class GetGroupsUseCase {
  const GetGroupsUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  Future<Either<Failure, List<GroupListItemEntity>>> call() {
    return groupRepository.getGroups();
  }
}