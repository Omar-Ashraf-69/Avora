import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/domain/use_case/get_messages_use_case.dart';
import 'package:avora/features/chats/domain/use_case/send_text_message_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.getMessagesUseCase,
    required this.sendTextMessageUseCase,
  }) : super(const ChatInitial());

  final GetMessagesUseCase getMessagesUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;

  Future<void> loadMessages({
    required String conversationId,
  }) async {
    emit(const ChatLoading());

    final result = await getMessagesUseCase(
      conversationId: conversationId,
    );

    result.fold(
      (failure) {
        emit(
          ChatFailure(
            message: failure.message,
          ),
        );
      },
      (messages) {
        emit(
          ChatLoaded(
            messages: messages,
          ),
        );
      },
    );
  }

  Future<void> sendTextMessage({
    required String conversationId,
    required String content,
  }) async {
    final trimmedContent = content.trim();

    if (trimmedContent.isEmpty) {
      return;
    }

    final currentState = state;

    if (currentState is! ChatLoaded) {
      return;
    }

    emit(
      ChatSending(
        messages: currentState.messages,
      ),
    );

    final result = await sendTextMessageUseCase(
      conversationId: conversationId,
      content: trimmedContent,
    );

    result.fold(
      (failure) {
        emit(
          ChatLoaded(
            messages: currentState.messages,
            errorMessage: failure.message,
          ),
        );
      },
      (message) {
        emit(
          ChatLoaded(
            messages: [
              ...currentState.messages,
              message,
            ],
          ),
        );
      },
    );
  }
}