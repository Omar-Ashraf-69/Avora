import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/entities/conversation_preview_entity.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ConversationRepository {
  Future<Either<Failure, String>> createDirectConversation({
    required String otherUserId,
  });
  Future<Either<Failure, List<ConversationPreviewEntity>>> getConversations();
  Future<Either<Failure, ProfileEntity>> getOtherParticipant({
    required String conversationId,
  });
}
