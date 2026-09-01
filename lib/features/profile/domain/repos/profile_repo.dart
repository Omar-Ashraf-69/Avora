import 'package:avora/core/error/failures.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> createProfile({
    required ProfileEntity profile,
  });
Future<Either<Failure, ProfileEntity?>> getProfile({
    required String userId,
  });
  Future<Either<Failure, ProfileEntity>> getCurrentProfile();

  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String username,
    required String name,
    String? about,
    String? avatarUrl,
  });
}