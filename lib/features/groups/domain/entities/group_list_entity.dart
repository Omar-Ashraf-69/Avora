import 'package:avora/features/chats/domain/entities/message_entity.dart';

class GroupListItemEntity {
  const GroupListItemEntity({
    required this.conversationId,
    required this.groupId,
    required this.name,
    this.avatarUrl,
    this.lastMessage,
    this.lastMessageAt,
    this.lastMessageSenderId,
    this.lastMessageType,
    required this.unreadCount,
  });

  final String conversationId;
  final String groupId;
  final String name;
  final String? avatarUrl;

  final String? lastMessage;
  final DateTime? lastMessageAt;
  final String? lastMessageSenderId;
  final MessageType? lastMessageType;

  final int unreadCount;
}