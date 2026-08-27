class ProfileEntity {
  final String id;
  final String username;
  final String name;
  final String phoneNumber;
  final String email;
  final String? about;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProfileEntity({
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
}