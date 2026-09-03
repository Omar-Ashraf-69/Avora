import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/failures.dart';
import 'package:avora/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:avora/features/profile/data/models/create_profile_model.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:avora/features/profile/domain/entities/public_profile_entity.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:avora/features/profile/domain/repos/profile_repo.dart';
import 'package:avora/generated/l10n.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, ProfileEntity>> createProfile({
    required ProfileEntity profile,
  }) async {
    return await _execute<ProfileEntity>(
      operation: 'createProfile',
      action: () async {
        final model = await _remoteDataSource.createProfile(
          CreateProfileModel(
            username: profile.username,
            name: profile.name,
            phoneNumber: profile.phoneNumber,
            email: profile.email,
            about: profile.about,
            avatarUrl: profile.avatarUrl,
          ),
        );

        return model.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, ProfileEntity>> getCurrentProfile() async {
    return await _execute<ProfileEntity>(
      operation: 'getCurrentProfile',
      action: () async {
        final model = await _remoteDataSource.getCurrentProfile();

        return model.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String username,
    required String name,
    String? about,
    String? avatarUrl,
  }) async {
    return await _execute<ProfileEntity>(
      operation: 'updateProfile',
      action: () async {
        final model = await _remoteDataSource.updateProfile(
          username: username,
          name: name,
          about: about,
          avatarUrl: avatarUrl,
        );

        return model.toEntity();
      },
    );
  }

  @override
  Future<Either<Failure, ProfileEntity?>> getProfile({
    required String userId,
  }) async {
    return await _execute<ProfileEntity?>(
      operation: 'getProfile',
      action: () async {
        final model = await _remoteDataSource.getProfile(userId: userId);

        return model?.toEntity();
      },
    );
  }

  @override
Future<Either<Failure, PublicProfileEntity?>> findUser({
  required UserIdentifier identifier,
}) async {
  return await _execute<PublicProfileEntity?>(
    operation: 'findUser',
    action: () async {
      final model = await _remoteDataSource.findUser(identifier: identifier);

      return model?.toEntity();
    },
  );
  
}

  Future<Either<Failure, T>> _execute<T>({
    required String operation,
    required Future<T> Function() action,
  }) async {
    try {
      return Right(await action());
    } on CustomException catch (e) {
      log('ProfileRepositoryImpl.$operation', error: e);

      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      log('ProfileRepositoryImpl.$operation', error: e, stackTrace: stackTrace);

      return Left(ServerFailure(S.current.unexpected_error));
    }
  }

}
