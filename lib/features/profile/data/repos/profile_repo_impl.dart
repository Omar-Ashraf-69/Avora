import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/failures.dart';
import 'package:avora/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:avora/features/profile/data/models/create_profile_model.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
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
    try {
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

      return Right(model.toEntity());
    } on CustomException catch (e) {
      log(
        'ProfileRepositoryImpl.createProfile',
        error: e,
      );

      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      log(
        'ProfileRepositoryImpl.createProfile',
        error: e,
        stackTrace: stackTrace,
      );

      return Left(
        ServerFailure(S.current.unexpected_error),
      );
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getCurrentProfile() async {
    try {
      final model = await _remoteDataSource.getCurrentProfile();

      return Right(model.toEntity());
    } on CustomException catch (e) {
      log(
        'ProfileRepositoryImpl.getCurrentProfile',
        error: e,
      );

      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      log(
        'ProfileRepositoryImpl.getCurrentProfile',
        error: e,
        stackTrace: stackTrace,
      );

      return Left(
        ServerFailure(S.current.unexpected_error),
      );
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String username,
    required String name,
    String? about,
    String? avatarUrl,
  }) async {
    try {
      final model = await _remoteDataSource.updateProfile(
        username: username,
        name: name,
        about: about,
        avatarUrl: avatarUrl,
      );

      return Right(model.toEntity());
    } on CustomException catch (e) {
      log(
        'ProfileRepositoryImpl.updateProfile',
        error: e,
      );

      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      log(
        'ProfileRepositoryImpl.updateProfile',
        error: e,
        stackTrace: stackTrace,
      );

      return Left(
        ServerFailure(S.current.unexpected_error),
      );
    }
  }

  @override
Future<Either<Failure, ProfileEntity?>> getProfile({
  required String userId,
}) async {
  try {
    final profileModel = await _remoteDataSource.getProfile(
      userId: userId,
    );

    if (profileModel == null) {
      return const Right(null);
    }

    return Right(profileModel.toEntity());
  } on CustomException catch (e) {
    log(
      'ProfileRepositoryImpl.getProfile',
      error: e,
    );

    return Left(ServerFailure(e.message));
  } catch (e, stackTrace) {
    log(
      'ProfileRepositoryImpl.getProfile',
      error: e,
      stackTrace: stackTrace,
    );

    return Left(ServerFailure(S.current.unexpected_error));
  }
}
}