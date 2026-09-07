enum MessageType {
  text,
  image,
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
  });

  final String id;
  final String conversationId;
  final String senderId;

  final MessageType type;

  final String? content;
  final String? imageUrl;

  final DateTime createdAt;
  final DateTime updatedAt;
}