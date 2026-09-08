import 'dart:io';

import 'package:avora/features/chats/data/data_source/image_storage_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageStorageDataSourceImpl implements ImageStorageDataSource {
  const ImageStorageDataSourceImpl({
    required this.supabaseClient,
  });

  final SupabaseClient supabaseClient;

  static const _bucketName = 'chat-images';

  @override
  Future<String> uploadChatImage({
    required String conversationId,
    required String messageId,
    required String filePath,
  }) async {
    final file = File(filePath);

    final extension = filePath.split('.').last.toLowerCase();

    final path =
        '$conversationId/$messageId.$extension';

    await supabaseClient.storage
        .from(_bucketName)
        .upload(
          path,
          file,
          fileOptions: const FileOptions(
            upsert: false,
          ),
        );

    return path;
  }

  @override
  Future<String> createSignedUrl({
    required String path,
  }) {
    return supabaseClient.storage
        .from(_bucketName)
        .createSignedUrl(
          path,
          60 * 60,
        );
  }

  @override

  Future<void> deleteChatImage({
    required String path,
  }) async {
    await supabaseClient.storage
        .from(_bucketName)
        .remove([path]);
  }
}