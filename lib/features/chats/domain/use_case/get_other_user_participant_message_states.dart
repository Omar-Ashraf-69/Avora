import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/entities/conversation_message_status.dart';
import 'package:avora/features/chats/domain/repos/message_repository.dart';
import 'package:dartz/dartz.dart';

class GetOtherParticipantMessageStatusUseCase {
  const GetOtherParticipantMessageStatusUseCase(this._repository);

  final MessageRepository _repository;

  Future<Either<Failure, ConversationMessageStatus>> call({
    required String conversationId,
  }) {
    return _repository.getOtherParticipantMessageStatus(
      conversationId: conversationId,
    );
  }
}