abstract class ProfileAvatarStorageDataSource {
  Future<String> uploadAvatar({
    required String userId,
    required String filePath,
  });

  Future<void> deleteAvatar({
    required String path,
  });
}

