import 'package:avora/core/error/failures.dart';
import 'package:avora/features/groups/data/params/create_group_params.dart';
import 'package:avora/features/groups/domain/repos/group_repo.dart';
import 'package:dartz/dartz.dart';

class CreateGroupUseCase {
  const CreateGroupUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  Future<Either<Failure, String>> call({
    required CreateGroupParams params,
  }) {
    return groupRepository.createGroup(
      params: params,
    );
  }
}