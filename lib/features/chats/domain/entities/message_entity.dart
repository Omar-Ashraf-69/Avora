enum MessageType { text, image }

enum MessageStatus { sent, delivered, seen }

class MessageEntity {
  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.content,
    this.imageUrl, this.status,
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
}
