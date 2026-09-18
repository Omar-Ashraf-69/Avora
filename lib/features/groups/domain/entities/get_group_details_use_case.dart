import 'package:avora/core/error/failures.dart';
import 'package:avora/features/groups/domain/entities/group_details_entity.dart';
import 'package:avora/features/groups/domain/repos/group_repo.dart';
import 'package:dartz/dartz.dart';

class GetGroupDetailsUseCase {
  const GetGroupDetailsUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  Future<Either<Failure, GroupDetailsEntity>> call({
    required String conversationId,
  }) {
    return groupRepository.getGroupDetails(
      conversationId: conversationId,
    );
  }
}