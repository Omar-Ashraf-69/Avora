import 'package:avora/features/chats/domain/use_case/create_direct_conversation.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:avora/features/profile/domain/use_cases/find_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit({
    required this.createDirectConversationUseCase,
    required this.findUserUseCase,
  }) : super(const ConversationInitial());

  final CreateDirectConversationUseCase createDirectConversationUseCase;

  Future<void> createDirectConversation({required String otherUserId}) async {
    emit(const ConversationLoading());

    final result = await createDirectConversationUseCase(
      otherUserId: otherUserId,
    );

    result.fold(
      (failure) {
        emit(ConversationFailure(message: failure.message));
      },
      (conversationId) {
        emit(DirectConversationCreated(conversationId: conversationId));
      },
    );
  }

  final FindUserUseCase findUserUseCase;

  Future<void> startDirectConversation({
    required UserIdentifier identifier,
  }) async {
    emit(const ConversationLoading());

    final userResult = await findUserUseCase(identifier: identifier);

    final user = userResult.fold(
      (failure) {
        emit(ConversationFailure(message: failure.message));

        return null;
      },
      (user) {
        return user;
      },
    );

    if (user == null) {
      emit(const ConversationFailure(message: 'User not found'));

      return;
    }

    final conversationResult = await createDirectConversationUseCase(
      otherUserId: user.id,
    );

    conversationResult.fold(
      (failure) {
        emit(ConversationFailure(message: failure.message));
      },
      (conversationId) {
        emit(DirectConversationCreated(conversationId: conversationId));
      },
    );
  }
}
