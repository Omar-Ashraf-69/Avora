import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/entities/conversation_message_status.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required String conversationId,
  });

  Future<Either<Failure, MessageEntity>> sendTextMessage({
    required String conversationId,
    required String content,
  });
Future<Either<Failure, MessageEntity>> sendImageMessage({
  required String conversationId,
  required String filePath,  String? content,

});
  Future<Either<Failure, void>> markConversationAsRead({
  required String conversationId,
});
Future<Either<Failure, void>> markConversationAsDelivered({
  required String conversationId,
});Future<Either<Failure, ConversationMessageStatus>>
    getOtherParticipantMessageStatus({
  required String conversationId,
});Future<Either<Failure, void>> markPendingMessagesAsDelivered();
}