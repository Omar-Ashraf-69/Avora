import 'package:avora/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {

  Future<Either<Failure, User>> signUpNewUser({required String email, required String password});

  Future<Either<Failure, User>> signInWithEmail({required String email, required String password});

  User? getCurrentUser();

  Future<void> signOut();
}