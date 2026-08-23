import 'dart:developer';

import 'package:avora/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<Either<Failure, User>> signUpNewUser({
    required String email,
    required String password,
  }) async {
    try {
     final res =  await _client.auth.signUp(email: email, password: password);
      return right(res.user!);
    } on Exception catch (e) {
      log(" AuthRemoteDataSource  signUpNewUser error: ");
      log(e.toString());
      return left(ServerFailure( e.toString()));
    }
  }

  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return right(res.user!);
    } on Exception catch (e) {
      log(" AuthRemoteDataSource  signInWithEmail error: ");
      log(e.toString());
      return left(ServerFailure( e.toString()));
    }
  }

  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  Stream<AuthState> get authStateChanges {
    return _client.auth.onAuthStateChange;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
