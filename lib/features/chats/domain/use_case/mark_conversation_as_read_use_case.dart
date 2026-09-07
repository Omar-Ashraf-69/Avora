import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/repos/message_repository.dart';
import 'package:dartz/dartz.dart';

class MarkConversationAsReadUseCase {
  const MarkConversationAsReadUseCase(this._repository);

  final MessageRepository _repository;

  Future<Either<Failure, void>> call({
    required String conversationId,
  }) {
    return _repository.markConversationAsRead(
      conversationId: conversationId,
    );
  }
}