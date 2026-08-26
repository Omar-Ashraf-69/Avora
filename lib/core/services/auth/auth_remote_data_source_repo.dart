import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSourceRepo {
  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  User? getCurrentUser();

  Future<void> deleteCurrentUser();

  Future<UserModel> signInWithGoogle();

  Future<void> signOut();


   Future<void> sendPasswordResetEmail({
    required String email,
  });

  Future<void> updatePassword({
    required String password,
  });
}
