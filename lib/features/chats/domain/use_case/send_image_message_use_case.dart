import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/domain/repos/message_repository.dart';
import 'package:dartz/dartz.dart';

class SendImageMessageUseCase {
  const SendImageMessageUseCase(
    this.repository,
  );

  final MessageRepository repository;

  Future<Either<Failure, MessageEntity>> call({
    required String conversationId,
    required String filePath,
  }) {
    return repository.sendImageMessage(
      conversationId: conversationId,
      filePath: filePath,
    );
  }
}