import 'package:avora/features/profile/data/models/profile_model.dart';
import 'package:avora/features/profile/data/models/create_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> createProfile(CreateProfileModel profile);

  Future<ProfileModel> getCurrentProfile();

  Future<ProfileModel> updateProfile({
    required String username,
    required String name,
    String? about,
    String? avatarUrl,
  });

  Future<ProfileModel?> getProfile({required String userId});
}
