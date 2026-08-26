import 'package:avora/core/error/failures.dart';
import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {

  Future<Either<Failure, UserModel>> signUpNewUser({required String email, required String password});

  Future<Either<Failure, UserModel>> signInWithEmail({required String email, required String password});

  Future<Either<Failure, UserModel>> signInWithGoogle();

  Future<Either<Failure, void>> sendPasswordResetEmail({
    required String email,
  });

  Future<Either<Failure, void>> updatePassword({
    required String password,
  });

  User? getCurrentUser();

  Future<Either<Failure, void>> deleteCurrentUser();
  Future<Either<Failure, void>> signOut();
}