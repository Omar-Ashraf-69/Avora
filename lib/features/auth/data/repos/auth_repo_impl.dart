import 'dart:developer';

import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/error/failures.dart';
import 'package:avora/core/services/auth/auth_remote_data_source_repo.dart';
import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSourceRepo _remoteDataSource;

  @override
  Future<Either<Failure, void>> signOut() async {
    return _executeVoidOperation(
      () => _remoteDataSource.signOut(),
      methodName: "signOut",
    );
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _executeSignInOperation(
      () => _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
      methodName: "signInWithEmail",
    );
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    return await _executeSignInOperation(
      () => _remoteDataSource.signInWithGoogle(),
      methodName: "signInWithGoogle",
    );
  }

  @override
  Future<Either<Failure, UserModel>> signUpNewUser({
    required String email,
    required String password,
  }) async {
    return await _executeSignUpOperation(
      () => _remoteDataSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
      methodName: "signUpNewUser",
    );
  }

  @override
  User? getCurrentUser() {
    return _remoteDataSource.getCurrentUser();
  }

  @override
  Future<Either<Failure, void>> deleteCurrentUser() async {
    return await _executeVoidOperation(
      () => _remoteDataSource.deleteCurrentUser(),
      methodName: "deleteCurrentUser",
    );
  }

  Future<Either<Failure, void>> _executeVoidOperation(
    Future<void> Function() operation, {
    required String methodName,
  }) async {
    try {
      await operation();
      return const Right(null);
    } on CustomException catch (e) {
      log('AuthRepoImpl.$methodName', error: e);
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      log('AuthRepoImpl.$methodName', error: e, stackTrace: stackTrace);
      return Left(ServerFailure(S.current.unexpected_error));
    }
  }

  Future<Either<Failure, UserModel>> _executeSignInOperation(
    Future<UserModel> Function() operation, {
    required String methodName,
  }) async {
    UserModel userModel;
    try {
      userModel = await operation();
      // bool isUserExists = await _databaseService.checkIfDataExists(
      //   docuementId: userModel.uId,
      //   path: BackendEndpoints.getUser,
      // );
      // if (!isUserExists) {
      //   await _databaseService.addData(
      //     path: BackendEndpoints.saveUser,
      //     documentId: userModel.uId,
      //     data: userModel.toJson(),
      //   );
      //   await LocalUserDataSource.saveUserLocally(userModel);
      // } else {
      //   final res =
      //       (await _databaseService.getData(
      //             docuementId: userModel.uId,
      //             path: BackendEndpoints.getUser,
      //           ))
      //           as Map<String, dynamic>;
      //   userModel = UserModel.fromJson(res);
      //   if (!await LocalUserDataSource.checkUserExists()) {
      //     await LocalUserDataSource.saveUserLocally(userModel);
      //   }
      // }
      return Right(userModel);
    } on CustomException catch (e) {
      log('AuthRepoImpl.$methodName', error: e);
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      log('AuthRepoImpl.$methodName', error: e, stackTrace: stackTrace);
      return Left(ServerFailure(S.current.unexpected_error));
    }
  }

  Future<Either<Failure, UserModel>> _executeSignUpOperation(
    Future<UserModel> Function() operation, {
    required String methodName,
  }) async {
    try {
      final userModel = await operation();
      // await _databaseService.addData(
      //   data: userModel.toJson(),
      //   path: BackendEndpoints.saveUser,
      //   documentId: userModel.uId,
      // );
      // await LocalUserDataSource.saveUserLocally(userModel);
      return Right(userModel);
    } on CustomException catch (e) {
      log('AuthRepoImpl.$methodName', error: e);
      //await _remoteDataSource.deleteCurrentUser();
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      //await _remoteDataSource.deleteCurrentUser();
      log('AuthRepoImpl.$methodName', error: e, stackTrace: stackTrace);
      return Left(ServerFailure(S.current.unexpected_error));
    }
  }
}
