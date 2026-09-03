import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/services/auth/auth_remote_data_source_repo.dart';
import 'package:avora/core/services/database/data_base_service.dart';
import 'package:avora/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:avora/features/profile/data/models/create_profile_model.dart';
import 'package:avora/features/profile/data/models/profile_model.dart';
import 'package:avora/features/profile/data/models/public_profile_model.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({
    required this.databaseService,
    required this.authRemoteDataSource,
  });

  final DatabaseService databaseService;
  final AuthRemoteDataSourceRepo authRemoteDataSource;

  static const String _table = 'profiles';

  User _requireCurrentUser() {
    final user = authRemoteDataSource.getCurrentUser();

    if (user == null) {
      throw const CustomException(message: 'User is not authenticated.');
    }

    return user;
  }

  @override
  Future<ProfileModel> createProfile(CreateProfileModel profile) async {
    final user = _requireCurrentUser();

    final data = {'id': user.id, ...profile.toJson()};

    final response = await databaseService.insert(table: _table, data: data);

    return ProfileModel.fromJson(response);
  }

  @override
  Future<ProfileModel> getCurrentProfile() async {
    final user = _requireCurrentUser();
    final response = await databaseService.getById(table: _table, id: user.id);

    if (response == null) {
      throw const CustomException(message: 'Profile not found.');
    }

    return ProfileModel.fromJson(response);
  }

  @override
  Future<ProfileModel> updateProfile({
    required String username,
    required String name,
    String? about,
    String? avatarUrl,
  }) async {
    final user = _requireCurrentUser();
    final response = await databaseService.update(
      table: _table,
      id: user.id,
      data: {
        'username': username,
        'name': name,
        'about': about,
        'avatar_url': avatarUrl,
        'updated_at': DateTime.now().toIso8601String(),
      },
    );

    return ProfileModel.fromJson(response);
  }

  @override
  Future<ProfileModel?> getProfile({required String userId}) async {
    final data = await databaseService.getById(table: _table, id: userId);

    if (data == null) {
      return null;
    }

    return ProfileModel.fromJson(data);
  }

  @override
  Future<PublicProfileModel?> findUser({required UserIdentifier identifier}) async {
    final result = await databaseService.rpc(
      functionName: 'find_user_by_identifier',
      params: {
        'p_identifier_type': identifier.type.name,
        'p_identifier': identifier.value,
      },
    );

    if (result is! List || result.isEmpty) {
      return null;
    }

    final user = result.first as Map<String, dynamic>;

    return PublicProfileModel.fromJson(user);
  }
}
