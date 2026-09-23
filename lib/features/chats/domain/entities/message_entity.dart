enum MessageType {
  text,
  image,
  system,
}

enum MessageStatus {
  sent,
  delivered,
  seen,
}

enum SystemMessageType {
  membersAdded,
}

class MessageEntity {
  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.content,
    this.imageUrl,
    this.status,
    this.systemEvent,
    this.metadata,
  });

  final String id;
  final String conversationId;
  final String senderId;

  final MessageType type;

  final String? content;
  final String? imageUrl;

  final DateTime createdAt;
  final DateTime updatedAt;

  final MessageStatus? status;

  final SystemMessageType? systemEvent;
  final Map<String, dynamic>? metadata;
}