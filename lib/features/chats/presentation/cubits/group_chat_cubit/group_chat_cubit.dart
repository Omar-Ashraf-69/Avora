import 'dart:developer';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/chats/data/data_source/message_realtime_data_source.dart';
import 'package:avora/features/chats/data/models/message_model.dart';
import 'package:avora/features/chats/domain/use_case/get_messages_use_case.dart';
import 'package:avora/features/chats/domain/use_case/mark_conversation_as_delivered.dart';
import 'package:avora/features/chats/domain/use_case/mark_conversation_as_read_use_case.dart';
import 'package:avora/features/chats/domain/use_case/send_image_message_use_case.dart';
import 'package:avora/features/chats/domain/use_case/send_text_message_use_case.dart';
import 'package:avora/features/chats/presentation/cubits/group_chat_cubit/group_chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupChatCubit extends Cubit<GroupChatState> {
  GroupChatCubit({
    required this.getMessagesUseCase,
    required this.sendTextMessageUseCase,
    required this.sendImageMessageUseCase,
    required this.messageRealtimeDataSource,
    required this.markConversationAsReadUseCase,
    required this.markConversationAsDeliveredUseCase,
    required this.authRepository,
  }) : super(const GroupChatInitial());

  final GetMessagesUseCase getMessagesUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;
  final SendImageMessageUseCase sendImageMessageUseCase;

  final MessageRealtimeDataSource messageRealtimeDataSource;

  final MarkConversationAsReadUseCase markConversationAsReadUseCase;
  final MarkConversationAsDeliveredUseCase markConversationAsDeliveredUseCase;

  final AuthRepository authRepository;

  Future<void> loadMessages({required String conversationId}) async {
    emit(const GroupChatLoading());

    final result = await getMessagesUseCase(conversationId: conversationId);

    result.fold(
      (failure) {
        emit(GroupChatFailure(message: failure.message));
      },
      (messages) {
        emit(GroupChatLoaded(messages: messages));

        _subscribeToMessages(conversationId);

        markConversationAsDelivered(conversationId: conversationId);

        markConversationAsRead(conversationId: conversationId);
      },
    );
  }

  Future<void> sendTextMessage({
    required String conversationId,
    required String content,
  }) async {
    final result = await sendTextMessageUseCase(
      conversationId: conversationId,
      content: content,
    );

    result.fold(
      (failure) {
        log('GroupChatCubit.sendTextMessage', error: failure.message);
      },
      (message) {
        final currentState = state;

        if (currentState is! GroupChatLoaded) return;

        if (currentState.messages.any(
          (existingMessage) => existingMessage.id == message.id,
        )) {
          return;
        }

        emit(GroupChatLoaded(messages: [...currentState.messages, message]));
      },
    );
  }

  Future<bool> sendImageMessage({
    required String conversationId,
    required String imagePath,
    String? content,
  }) async {
    final result = await sendImageMessageUseCase(
      filePath: imagePath,
      conversationId: conversationId,
      content: content,
    );
    return result.fold(
      (failure) {
        log('GroupChatCubit.sendImageMessage', error: failure.message);
        return false;
      },
      (message) {
        final currentState = state;
        if (currentState is! GroupChatLoaded) {
          return false;
        }
        if (currentState.messages.any(
          (existingMessage) => existingMessage.id == message.id,
        )) {
          return false;
        }
        emit(GroupChatLoaded(messages: [...currentState.messages, message]));
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

    if (currentState is! GroupChatLoaded) {
      return;
    }

    final message = model.toEntity();

    final alreadyExists = currentState.messages.any(
      (item) => item.id == message.id,
    );

    if (alreadyExists) {
      return;
    }

    emit(
      GroupChatLoaded(
        messages: [...currentState.messages, message],
        isSending: currentState.isSending,
      ),
    );

    final currentUser = authRepository.getCurrentUser();

    if (currentUser != null && message.senderId != currentUser.id) {
      markConversationAsDelivered(conversationId: message.conversationId);

      markConversationAsRead(conversationId: message.conversationId);
    }
  }

  void _onMessageUpdated(MessageModel model) {
    final currentState = state;

    if (currentState is! GroupChatLoaded) {
      return;
    }

    final updatedMessage = model.toEntity();

    final messages = currentState.messages.map((message) {
      if (message.id == updatedMessage.id) {
        return updatedMessage;
      }

      return message;
    }).toList();

    emit(
      GroupChatLoaded(messages: messages, isSending: currentState.isSending),
    );
  }

  void _onMessageDeleted(String messageId) {
    final currentState = state;

    if (currentState is! GroupChatLoaded) {
      return;
    }

    final messages = currentState.messages
        .where((message) => message.id != messageId)
        .toList();

    emit(
      GroupChatLoaded(messages: messages, isSending: currentState.isSending),
    );
  }

  Future<void> markConversationAsRead({required String conversationId}) async {
    await markConversationAsReadUseCase(conversationId: conversationId);
  }

  Future<void> markConversationAsDelivered({
    required String conversationId,
  }) async {
    await markConversationAsDeliveredUseCase(conversationId: conversationId);
  }

  @override
  Future<void> close() async {
  await messageRealtimeDataSource.unsubscribeFromMessages();

    return super.close();
  }
}
