class PublicProfileEntity {
  final String id;
  final String username;
  final String name;
  final String? avatarUrl;

  const PublicProfileEntity({
    required this.id,
    required this.username,
    required this.name,
    this.avatarUrl,
  });
}