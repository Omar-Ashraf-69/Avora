import 'package:avora/features/auth/data/models/user_model.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import '../../domain/entities/auth_user.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<void> sendOtp(String phoneNumber) {
    return _remoteDataSource.sendOtp(phoneNumber);
  }

  @override
  Future<AuthUser> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final user = await _remoteDataSource.verifyOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );

    return AuthUserModel.fromSupabase(user).toEntity();
  }

  @override
  AuthUser? getCurrentUser() {
    final user = _remoteDataSource.getCurrentUser();

    if (user == null) {
      return null;
    }

    return AuthUserModel.fromSupabase(user).toEntity();
  }

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }
}