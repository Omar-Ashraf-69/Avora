abstract class ImageStorageDataSource {
  Future<String> uploadChatImage({
    required String conversationId,
    required String messageId,
    required String filePath,
  });

  Future<String> createSignedUrl({
    required String path,
  });

  Future<void> deleteChatImage({
    required String path,
  });
}