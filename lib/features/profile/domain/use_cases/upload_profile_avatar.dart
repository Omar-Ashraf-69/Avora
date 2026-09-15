import 'package:avora/core/error/failures.dart';
import 'package:avora/features/profile/domain/repos/profile_avatar_repo.dart';
import 'package:dartz/dartz.dart';

class UploadProfileAvatarUseCase {
  const UploadProfileAvatarUseCase(this._repository);

  final ProfileAvatarRepository _repository;

  Future<Either<Failure, String>> call({
    required String userId,
    required String filePath,
  }) {
    return _repository.uploadAvatar(
      userId: userId,
      filePath: filePath,
    );
  }
}
