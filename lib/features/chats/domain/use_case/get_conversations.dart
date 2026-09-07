import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/entities/conversation_preview_entity.dart';
import 'package:avora/features/chats/domain/repos/conversation_repository.dart';
import 'package:dartz/dartz.dart';

class GetConversationsUseCase {
  const GetConversationsUseCase(this._repository);

  final ConversationRepository _repository;

  Future<Either<Failure, List<ConversationPreviewEntity>>> call() {
    return _repository.getConversations();
  }
}