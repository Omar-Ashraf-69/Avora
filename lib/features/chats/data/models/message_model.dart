import 'package:avora/features/chats/domain/entities/message_entity.dart';

class MessageModel {
  const MessageModel({
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

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      senderId: json['sender_id'] as String,
      type: MessageType.values.byName(
        json['type'] as String,
      ),
      content: json['content'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(
        json['created_at'] as String,
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] as String,
      ),
    );
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      type: type,
      content: content,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
          status: null,

    );
  }
}