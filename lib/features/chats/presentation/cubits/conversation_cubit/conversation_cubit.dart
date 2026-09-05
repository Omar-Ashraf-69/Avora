import 'package:avora/features/chats/domain/use_case/create_direct_conversation.dart';
import 'package:avora/features/profile/domain/entities/user_identifier.dart';
import 'package:avora/features/profile/domain/use_cases/find_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit({
    required this.findUserUseCase,
    required this.createDirectConversationUseCase,
  }) : super(const ConversationInitial());

  final FindUserUseCase findUserUseCase;
  final CreateDirectConversationUseCase
      createDirectConversationUseCase;

  Future<void> startDirectConversation({
    required UserIdentifier identifier,
  }) async {
    // ----------------------------------------------------------
    // Loading
    // ----------------------------------------------------------

    emit(const ConversationLoading());

    // ----------------------------------------------------------
    // Step 1: Find the user
    // ----------------------------------------------------------

    final userResult = await findUserUseCase(
      identifier: identifier,
    );

    // ----------------------------------------------------------
    // Step 2: Handle the result
    // ----------------------------------------------------------

    final user = userResult.fold(
      // Backend/database failure.
      (failure) {
        emit(
          ConversationFailure(
            message: failure.message,
          ),
        );

        return null;
      },

      // Successful request.
      (user) => user,
    );

    // ----------------------------------------------------------
    // IMPORTANT:
    // If userResult failed, we already emitted the failure above.
    //
    // Do NOT emit "User not found" again.
    // ----------------------------------------------------------

    if (userResult.isLeft()) {
      return;
    }

    // ----------------------------------------------------------
    // Step 3: User does not exist
    // ----------------------------------------------------------

    if (user == null) {
      emit(
        const ConversationFailure(
          message: 'User not found',
        ),
      );

      return;
    }

    // ----------------------------------------------------------
    // Step 4: Create/Get direct conversation
    // ----------------------------------------------------------
    //
    // The RPC is idempotent.
    //
    // If the conversation already exists:
    //     it returns the existing conversation ID.
    //
    // If it doesn't exist:
    //     it creates one and returns its ID.
    // ----------------------------------------------------------

    final conversationResult =
        await createDirectConversationUseCase(
      otherUserId: user.id,
    );

    conversationResult.fold(
      (failure) {
        emit(
          ConversationFailure(
            message: failure.message,
          ),
        );
      },
      (conversationId) {
        emit(
          DirectConversationCreated(
            conversationId: conversationId,
          ),
        );
      },
    );
  }
}