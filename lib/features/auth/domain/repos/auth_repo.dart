import 'package:avora/core/error/failures.dart';
import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {

  Future<Either<Failure, UserModel>> signUpNewUser({required String email, required String password});

  Future<Either<Failure, UserModel>> signInWithEmail({required String email, required String password});

  Future<Either<Failure, UserModel>> signInWithGoogle();

  User? getCurrentUser();

  Future<void> deleteCurrentUser();
  Future<void> signOut();
}