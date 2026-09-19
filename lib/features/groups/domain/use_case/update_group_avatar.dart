import 'package:avora/core/error/failures.dart';
import 'package:avora/features/groups/domain/repos/group_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateGroupAvatarUseCase {
  const UpdateGroupAvatarUseCase(this.groupRepository);

  final GroupRepository groupRepository;

  Future<Either<Failure, void>> call({
    required String conversationId,
    required String avatarUrl,
  }) {
    return groupRepository.updateGroupAvatar(
      conversationId: conversationId,
      avatarUrl: avatarUrl,
    );
  }
}