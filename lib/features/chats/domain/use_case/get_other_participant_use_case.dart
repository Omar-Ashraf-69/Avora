import 'package:avora/core/error/failures.dart';
import 'package:avora/features/chats/domain/repos/conversation_repository.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

class GetOtherParticipantUseCase {
  const GetOtherParticipantUseCase(this.repository);

  final ConversationRepository repository;

  Future<Either<Failure, ProfileEntity>> call({
    required String conversationId,
  }) {
    return repository.getOtherParticipant(
      conversationId: conversationId,
    );
  }
}