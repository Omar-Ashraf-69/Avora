import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/repos/conversation_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/conversation_entity.dart';

class GetUserConversationsUseCase {
  GetUserConversationsUseCase(this._repository);

  final ConversationRepository _repository;

  Future<Either<Failure, List<ConversationEntity>>> call() {
    return _repository.getUserConversations();
  }
}