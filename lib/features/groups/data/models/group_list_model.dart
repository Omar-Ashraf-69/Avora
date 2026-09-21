import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/groups/domain/entities/group_list_entity.dart';

class GroupListItemModel {
  const GroupListItemModel({
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

  factory GroupListItemModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return GroupListItemModel(
      conversationId: json['conversation_id'] as String,
      groupId: json['group_id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      lastMessage: json['last_message'] as String?,
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'] as String)
          : null,
      lastMessageSenderId:
          json['last_message_sender_id'] as String?,
      lastMessageType: json['last_message_type'] != null
          ? MessageType.values.byName(
              json['last_message_type'] as String,
            )
          : null,
      unreadCount: (json['unread_count'] as num).toInt(),
    );
  }

  GroupListItemEntity toEntity() {
    return GroupListItemEntity(
      conversationId: conversationId,
      groupId: groupId,
      name: name,
      avatarUrl: avatarUrl,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
      lastMessageSenderId: lastMessageSenderId,
      lastMessageType: lastMessageType,
      unreadCount: unreadCount,
    );
  }
}