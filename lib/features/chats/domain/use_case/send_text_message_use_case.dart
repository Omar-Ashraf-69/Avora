import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/domain/repos/message_repository.dart';
import 'package:dartz/dartz.dart';

class SendTextMessageUseCase {
  const SendTextMessageUseCase(this._repository);

  final MessageRepository _repository;

  Future<Either<Failure, MessageEntity>> call({
    required String conversationId,
    required String content,
  }) {
    return _repository.sendTextMessage(
      conversationId: conversationId,
      content: content,
    );
  }
}