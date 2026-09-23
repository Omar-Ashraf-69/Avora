import 'package:avora/features/chats/data/models/message_model.dart';

abstract class MessageRealtimeDataSource {
  Future<void> subscribeToMessages({
    required String conversationId,
    required void Function(MessageModel message) onMessageInserted,
    required void Function(MessageModel message) onMessageUpdated,
    required void Function(String messageId) onMessageDeleted,
  });

  Future<void> subscribeToConversations({
    required List<String> conversationIds,
    required void Function(MessageModel message) onMessageInserted,
    required void Function(MessageModel message) onMessageUpdated,
    required void Function(String messageId) onMessageDeleted,
  });

  void updateConversationIds(List<String> conversationIds);

  Future<void> unsubscribeFromMessages();

  Future<void> unsubscribeFromConversations();

  Future<void> unsubscribe();
}