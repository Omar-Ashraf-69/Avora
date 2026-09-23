import 'package:avora/core/error/failures.dart';
import 'package:avora/features/groups/domain/repos/group_repo.dart';
import 'package:dartz/dartz.dart';

class FinalizeGroupCreationUseCase {
  const FinalizeGroupCreationUseCase(
    this.groupRepository,
  );

  final GroupRepository groupRepository;

  Future<Either<Failure, void>> call({
    required String conversationId,
    required List<String> memberIds,
  }) {
    return groupRepository.finalizeGroupCreation(
      conversationId: conversationId,
      memberIds: memberIds,
    );
  }
}