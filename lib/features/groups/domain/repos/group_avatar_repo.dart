import 'package:avora/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class GroupAvatarRepository {
  Future<Either<Failure, String>> uploadAvatar({
    required String conversationId,
    required String filePath,
  });
  Future<Either<Failure, String>> getAvatarUrl({
    required String path,
  });
  Future<Either<Failure, void>> deleteAvatar({
    required String path,
  });
}