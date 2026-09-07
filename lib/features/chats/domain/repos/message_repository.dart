import 'package:avora/core/error/failures.dart';
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
}