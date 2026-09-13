import 'package:avora/features/chats/data/models/message_model.dart';
import 'package:avora/features/chats/domain/entities/conversation_message_status.dart';

abstract class MessageRemoteDataSource {
  Future<List<MessageModel>> getMessages({
    required String conversationId,
  });

  Future<MessageModel> sendTextMessage({
    required String conversationId,
    required String content,
  });Future<MessageModel> sendImageMessage({
  required String conversationId,
  required String messageId,
  required String imagePath,
    String? content,

});

   Future<void> markConversationAsRead({
    required String conversationId,
  });Future<void> markConversationAsDelivered({
  required String conversationId,
});Future<ConversationMessageStatus> getOtherParticipantMessageStatus({
  required String conversationId,
});
  Future<void> markPendingMessagesAsDelivered();

}