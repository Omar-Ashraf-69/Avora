class GroupEntity {
  const GroupEntity({
    required this.id,
    required this.conversationId,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.avatarUrl,
  });

  final String id;
  final String conversationId;
  final String name;
  final String? description;
  final String? avatarUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
}