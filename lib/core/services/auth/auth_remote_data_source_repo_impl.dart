import 'package:avora/core/services/auth/auth_remote_data_source_repo.dart';
import 'package:avora/core/services/auth/supabase_auth_service.dart';
import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSourceRepoImpl implements AuthRemoteDataSourceRepo {
  SupabaseAuthService authService;

  AuthRemoteDataSourceRepoImpl({required this.authService});
  @override
  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await authService.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return UserModel(email: user.email!, id: user.id);
  }

  @override
  Future<void> deleteCurrentUser() async {
    await authService.deleteCurrentUser();
  }

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel(email: user.email!, id: user.id);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final user = await authService.signInWithGoogle();
    return UserModel(email: user.user!.email!, id: user.user!.id);
  }

  @override
  Future<void> signOut() async {
    await authService.signOut();
  }

  @override
  User? getCurrentUser() {
    final user = authService.currentUser;
    return user;
  }
}
