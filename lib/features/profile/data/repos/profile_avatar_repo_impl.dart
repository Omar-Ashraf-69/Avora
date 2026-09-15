
import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/failures.dart';
import 'package:avora/features/profile/data/data_sources/profile_avatar_storage_data_source.dart';
import 'package:avora/features/profile/domain/repos/profile_avatar_repo.dart';
import 'package:dartz/dartz.dart';

class ProfileAvatarRepositoryImpl implements ProfileAvatarRepository {
  const ProfileAvatarRepositoryImpl({required this.storageDataSource});

  final ProfileAvatarStorageDataSource storageDataSource;

  @override
  Future<Either<Failure, String>> uploadAvatar({
    required String userId,
    required String filePath,
  }) async {
    try {
      final path = await storageDataSource.uploadAvatar(
        userId: userId,
        filePath: filePath,
      );

      return Right(path);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(const ServerFailure('Failed to upload profile image.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAvatar({required String path}) async {
    try {
      await storageDataSource.deleteAvatar(path: path);

      return const Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return Left(const ServerFailure('Failed to delete profile image.'));
    }
  }
}
