import 'dart:io';

import 'package:avora/features/profile/data/data_sources/profile_avatar_storage_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileAvatarStorageDataSourceImpl
    implements ProfileAvatarStorageDataSource {
  const ProfileAvatarStorageDataSourceImpl({required this.supabaseClient});

  final SupabaseClient supabaseClient;

  static const _bucketName = 'profile-avatars';

  @override
  Future<String> uploadAvatar({
    required String userId,
    required String filePath,
  }) async {
    final file = File(filePath);

    final extension = filePath.split('.').last.toLowerCase();

    final path = '$userId/avatar.$extension';

    await supabaseClient.storage
        .from(_bucketName)
        .upload(path, file, fileOptions: const FileOptions(upsert: true));
    final publicUrl = supabaseClient.storage
        .from(_bucketName)
        .getPublicUrl(path);

    return publicUrl;
  }

  @override
  Future<void> deleteAvatar({required String path}) async {
    await supabaseClient.storage.from(_bucketName).remove([path]);
  }
}
