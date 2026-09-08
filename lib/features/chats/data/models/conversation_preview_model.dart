import 'package:avora/features/chats/domain/entities/conversation_entity.dart';
import 'package:avora/features/chats/domain/entities/conversation_preview_entity.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';

class ConversationPreviewModel {
  const ConversationPreviewModel({
    required this.conversationId,
    required this.type,
    required this.title,
    this.avatarUrl,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.lastMessageSenderId,
    this.lastMessageType,
  });

  final String conversationId;
  final ConversationType type;

  final String title;
  final String? avatarUrl;
  final String? lastMessageSenderId;
  final MessageType? lastMessageType;

  final String? lastMessage;
  final DateTime? lastMessageAt;

  final int unreadCount;

  factory ConversationPreviewModel.fromJson(Map<String, dynamic> json) {
    return ConversationPreviewModel(
      conversationId: json['conversation_id'] as String,
      type: ConversationType.values.byName(json['type'] as String),
      title: json['title'] as String,
      avatarUrl: json['avatar_url'] as String?,
      lastMessage: json['last_message'] as String?,
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'] as String)
          : null,
      lastMessageSenderId: json['last_message_sender_id'] as String?,
      lastMessageType: json['last_message_type'] == null
          ? null
          : MessageType.values.byName(json['last_message_type'] as String),
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
    );
  }

  ConversationPreviewEntity toEntity() {
    return ConversationPreviewEntity(
      conversationId: conversationId,
      type: type,
      title: title,
      avatarUrl: avatarUrl,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
      lastMessageType: lastMessageType,
      unreadCount: unreadCount,
      lastMessageSenderId: lastMessageSenderId,
    );
  }
}
