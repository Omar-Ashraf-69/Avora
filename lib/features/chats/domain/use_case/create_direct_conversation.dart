import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/repos/conversation_repository.dart';
import 'package:dartz/dartz.dart';


class CreateDirectConversationUseCase {
  CreateDirectConversationUseCase(this._repository);

  final ConversationRepository _repository;

  Future<Either<Failure, String>> call({
    required String otherUserId,
  }) {
    return _repository.createDirectConversation(
      otherUserId: otherUserId,
    );
  }
}