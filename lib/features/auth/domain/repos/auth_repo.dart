import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<void> sendOtp(String phoneNumber);

  Future<AuthUser> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  AuthUser? getCurrentUser();

  Future<void> signOut();
}