import 'package:avora/features/chats/data/models/message_model.dart';

abstract class MessageRealtimeDataSource {
  void subscribeToMessages({
    required String conversationId,
    required void Function(MessageModel message) onMessageInserted,
    required void Function(MessageModel message) onMessageUpdated,
    required void Function(String messageId) onMessageDeleted,
  });

  Future<void> unsubscribe();
}