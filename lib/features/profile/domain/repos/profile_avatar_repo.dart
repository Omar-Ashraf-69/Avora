import 'package:avora/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileAvatarRepository {
  Future<Either<Failure, String>> uploadAvatar({
    required String userId,
    required String filePath,
  });

  Future<Either<Failure, void>> deleteAvatar({
    required String path,
  });
}
