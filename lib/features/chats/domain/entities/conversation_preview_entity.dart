import 'package:avora/features/chats/domain/entities/conversation_entity.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';

class ConversationPreviewEntity {
  const ConversationPreviewEntity({
    required this.conversationId,
    required this.type,
    required this.title,
    this.avatarUrl,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.isOnline = false,
    this.lastMessageSenderId, this.lastMessageType,
  });

  final String conversationId;
  final ConversationType type;

  final String title;
  final String? avatarUrl;
  final String? lastMessageSenderId;

  final String? lastMessage;
  final DateTime? lastMessageAt;
  final MessageType? lastMessageType;

  final int unreadCount;
  final bool isOnline;
}