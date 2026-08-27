import 'package:avora/features/profile/domain/entities/profile_entity.dart';

class ProfileModel {
  final String id;
  final String username;
  final String name;
  final String phoneNumber;
  final String email;
  final String? about;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProfileModel({
    required this.id,
    required this.username,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.about,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      about: json['about'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'about': about,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      username: username,
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      about: about,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}