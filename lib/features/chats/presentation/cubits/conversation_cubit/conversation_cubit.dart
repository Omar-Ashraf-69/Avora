import 'package:avora/features/chats/domain/use_case/create_direct_conversation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit({
    required this.createDirectConversationUseCase,
  }) : super(const ConversationInitial());

  final CreateDirectConversationUseCase createDirectConversationUseCase;

  Future<void> createDirectConversation({
    required String otherUserId,
  }) async {
    emit(const ConversationLoading());

    final result = await createDirectConversationUseCase(
      otherUserId: otherUserId,
    );

    result.fold(
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