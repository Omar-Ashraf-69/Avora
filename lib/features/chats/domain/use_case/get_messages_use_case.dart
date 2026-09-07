import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/domain/repos/message_repository.dart';
import 'package:dartz/dartz.dart';

class GetMessagesUseCase {
  const GetMessagesUseCase(this._repository);

  final MessageRepository _repository;

  Future<Either<Failure, List<MessageEntity>>> call({
    required String conversationId,
  }) {
    return _repository.getMessages(
      conversationId: conversationId,
    );
  }
}