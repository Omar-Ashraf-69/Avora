import 'package:avora/features/profile/domain/entities/public_profile_entity.dart';

class PublicProfileModel {
  final String id;
  final String username;
  final String name;
  final String? avatarUrl;

  const PublicProfileModel({
    required this.id,
    required this.username,
    required this.name,
    this.avatarUrl,
  });

  factory PublicProfileModel.fromJson(Map<String, dynamic> json) {
    return PublicProfileModel(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  PublicProfileEntity toEntity() {
    return PublicProfileEntity(
      id: id,
      username: username,
      name: name,
      avatarUrl: avatarUrl,
    );
  }
}