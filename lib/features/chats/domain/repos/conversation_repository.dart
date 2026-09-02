import 'package:avora/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/conversation_entity.dart';

abstract class ConversationRepository {
  Future<Either<Failure, String>> createDirectConversation({
    required String otherUserId,
  });

  Future<Either<Failure, List<ConversationEntity>>>
      getUserConversations();
}