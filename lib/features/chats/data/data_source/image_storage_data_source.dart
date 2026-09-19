abstract class ImageStorageDataSource {
  Future<String> uploadChatImage({
    required String conversationId,
    required String messageId,
    required String filePath,
  });
  // Group avatars
  Future<String> uploadGroupAvatar({
    required String conversationId,
    required String filePath,
  });
  Future<String> createSignedUrl({
    required String path,
    required String bucketName,
  });

  Future<void> deleteChatImage({required String path});
  Future<void> deleteGroupAvatar({required String path});
  String getGroupAvatarUrl({required String path});
}
