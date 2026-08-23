import 'package:avora/core/error/failures.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }

  @override
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<Failure, User>> signUpNewUser({
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource.signUpNewUser(
      email: email,
      password: password,
    );
  }

  @override
  User? getCurrentUser() {
    return _remoteDataSource.getCurrentUser();
  }
}
