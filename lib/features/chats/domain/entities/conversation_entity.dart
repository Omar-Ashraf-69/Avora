enum ConversationType {
  direct,
  group,
}

class ConversationEntity {
  const ConversationEntity({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final ConversationType type;
  final DateTime createdAt;
  final DateTime updatedAt;
}