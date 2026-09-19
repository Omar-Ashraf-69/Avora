import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/data/data_source/image_storage_data_source.dart';
import 'package:avora/features/groups/domain/repos/group_avatar_repo.dart';
import 'package:dartz/dartz.dart';

class GroupAvatarRepositoryImpl implements GroupAvatarRepository {
  const GroupAvatarRepositoryImpl({required this.storageDataSource});

  final ImageStorageDataSource storageDataSource;

  @override
  Future<Either<Failure, String>> uploadAvatar({
    required String conversationId,
    required String filePath,
  }) async {
    try {
      final path = await storageDataSource.uploadGroupAvatar(
        conversationId: conversationId,
        filePath: filePath,
      );

      final url = storageDataSource.getGroupAvatarUrl(path: path);

      return Right(url);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log("Failed to upload group image.$e");
      return const Left(ServerFailure('Failed to upload group image.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAvatar({required String path}) async {
    try {
      await storageDataSource.deleteGroupAvatar(path: path);

      return const Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Failed to delete group image.'));
    }
  }

  @override
  Future<Either<Failure, String>> getAvatarUrl({required String path}) async {
    try {
      final url = storageDataSource.getGroupAvatarUrl(path: path);

      return Right(url);
    } catch (_) {
      return const Left(ServerFailure('Failed to get group image URL.'));
    }
  }
}
