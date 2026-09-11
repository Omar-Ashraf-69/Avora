import 'package:avora/features/chats/data/data_source/message_realtime_data_source.dart';
import 'package:avora/features/chats/data/models/message_model.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/domain/use_case/get_messages_use_case.dart';
import 'package:avora/features/chats/domain/use_case/mark_conversation_as_read_use_case.dart';
import 'package:avora/features/chats/domain/use_case/send_image_message_use_case.dart';
import 'package:avora/features/chats/domain/use_case/send_text_message_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.getMessagesUseCase,
    required this.sendTextMessageUseCase,
    required this.messageRealtimeDataSource,
    required this.markConversationAsReadUseCase, required this.sendImageMessageUseCase,
  }) : super(const ChatInitial());

  final GetMessagesUseCase getMessagesUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;
  final MarkConversationAsReadUseCase markConversationAsReadUseCase;
  final MessageRealtimeDataSource messageRealtimeDataSource;
final SendImageMessageUseCase sendImageMessageUseCase;

  Future<void> loadMessages({required String conversationId}) async {

    emit(const ChatLoading());

    final result = await getMessagesUseCase(conversationId: conversationId);

    result.fold(
      (failure) {
        emit(ChatFailure(message: failure.message));
      },
      (messages) {
        emit(ChatLoaded(messages: messages));
        _subscribeToMessages(conversationId);
        markConversationAsRead(conversationId: conversationId);
      },
    );
  }

  Future<void> markConversationAsRead({required String conversationId}) async {
    await markConversationAsReadUseCase(conversationId: conversationId);
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
        emit(ChatLoaded(messages: [...currentState.messages, message]));
      },
    );
  }
Future<bool> sendImageMessage({
  required String conversationId,
  required String filePath,
    String? content,

}) async {
  final currentState = state;

  if (currentState is! ChatLoaded) {
    return false;
  }

  final result = await sendImageMessageUseCase(
    conversationId: conversationId,
    filePath: filePath,
    content: content,
  );

  return result.fold(
    (failure) {
      emit(
        ChatLoaded(
          messages: currentState.messages,
          errorMessage: failure.message,
        ),
      );

      return false;
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

      return true;
    },
  );
}
  void _subscribeToMessages(String conversationId) {
    messageRealtimeDataSource.subscribeToMessages(
      conversationId: conversationId,

      onMessageInserted: _onMessageInserted,

      onMessageUpdated: _onMessageUpdated,

      onMessageDeleted: _onMessageDeleted,
    );
  }

  void _onMessageInserted(MessageModel model) {
    final currentState = state;

    if (currentState is! ChatLoaded) return;

    final message = model.toEntity();

    final alreadyExists = currentState.messages.any(
      (item) => item.id == message.id,
    );

    if (alreadyExists) return;

    emit(ChatLoaded(messages: [...currentState.messages, message], isSending: currentState.isSending,));
    markConversationAsRead(conversationId: message.conversationId);
  }

  void _onMessageUpdated(MessageModel model) {
    final currentState = state;

    if (currentState is! ChatLoaded) return;

    final updatedMessage = model.toEntity();

    final messages = currentState.messages.map((message) {
      if (message.id == updatedMessage.id) {
        return updatedMessage;
      }

      return message;
    }).toList();

    emit(ChatLoaded(messages: messages));
  }

  void _onMessageDeleted(String messageId) {
    final currentState = state;

    if (currentState is! ChatLoaded) return;

    final messages = currentState.messages
        .where((message) => message.id != messageId)
        .toList();

    emit(ChatLoaded(messages: messages));
  }

  @override
  Future<void> close() async {
    await messageRealtimeDataSource.unsubscribe();

    return super.close();
  }
}
