import 'package:avora/features/groups/domain/repos/group_avatar_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:avora/core/error/failures.dart';

class UploadGroupAvatarUseCase {
  const UploadGroupAvatarUseCase(
    this.groupAvatarRepository,
  );

  final GroupAvatarRepository groupAvatarRepository;

  Future<Either<Failure, String>> call({
    required String conversationId,
    required String filePath,
  }) {
    return groupAvatarRepository.uploadAvatar(
      conversationId: conversationId,
      filePath: filePath,
    );
  }
}