import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<void> sendOtp(String phoneNumber) async {
    await _client.auth.signInWithOtp(
      phone: phoneNumber,
    );
  }

  Future<User> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final response = await _client.auth.verifyOTP(
      type: OtpType.sms,
      phone: phoneNumber,
      token: otp,
    );

    final user = response.user;

    if (user == null) {
      throw const AuthException(
        'Authentication failed. User was not returned.',
      );
    }

    return user;
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