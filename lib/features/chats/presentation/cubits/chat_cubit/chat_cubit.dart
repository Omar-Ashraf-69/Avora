import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/chats/data/data_source/conversation_status_realtime_data_source.dart';
import 'package:avora/features/chats/data/data_source/message_realtime_data_source.dart';
import 'package:avora/features/chats/data/models/message_model.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/domain/use_case/get_messages_use_case.dart';
import 'package:avora/features/chats/domain/use_case/get_other_user_participant_message_states.dart';
import 'package:avora/features/chats/domain/use_case/mark_conversation_as_delivered.dart';
import 'package:avora/features/chats/domain/use_case/mark_conversation_as_read_use_case.dart';
import 'package:avora/features/chats/domain/use_case/send_image_message_use_case.dart';
import 'package:avora/features/chats/domain/use_case/send_text_message_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.getMessagesUseCase,
    required this.sendTextMessageUseCase,
    required this.sendImageMessageUseCase,
    required this.messageRealtimeDataSource,
    required this.conversationStatusRealtimeDataSource,
    required this.markConversationAsReadUseCase,
    required this.markConversationAsDeliveredUseCase,
    required this.authRepository,
    required this.getOtherParticipantMessageStatusUseCase,
  }) : super(const ChatInitial());

  final GetMessagesUseCase getMessagesUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;
  final SendImageMessageUseCase sendImageMessageUseCase;

  final MarkConversationAsReadUseCase markConversationAsReadUseCase;
  final MarkConversationAsDeliveredUseCase markConversationAsDeliveredUseCase;

  final MessageRealtimeDataSource messageRealtimeDataSource;
  final ConversationStatusRealtimeDataSource
  conversationStatusRealtimeDataSource;
  final GetOtherParticipantMessageStatusUseCase
  getOtherParticipantMessageStatusUseCase;
  final AuthRepository authRepository;

  DateTime? _otherLastDeliveredAt;
  DateTime? _otherLastReadAt;
  Future<void> loadMessages({required String conversationId}) async {
    emit(const ChatLoading());

    final messagesResult = await getMessagesUseCase(
      conversationId: conversationId,
    );

    final messages = messagesResult.fold((failure) {
      emit(ChatFailure(message: failure.message));

      return null;
    }, (messages) => messages);

    if (messages == null) {
      return;
    }

    final statusResult = await getOtherParticipantMessageStatusUseCase(
      conversationId: conversationId,
    );

    statusResult.fold(
      (failure) {
        emit(ChatFailure(message: failure.message));
      },
      (status) {
        _otherLastDeliveredAt = status.lastDeliveredAt;
        _otherLastReadAt = status.lastReadAt;

        emit(ChatLoaded(messages: messages));

        _subscribeToMessages(conversationId);
        _subscribeToConversationStatus(conversationId);

        markConversationAsDelivered(conversationId: conversationId);

        markConversationAsRead(conversationId: conversationId);
      },
    );
  }

  Future<void> markConversationAsDelivered({
    required String conversationId,
  }) async {
    await markConversationAsDeliveredUseCase(conversationId: conversationId);
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
            isSending: currentState.isSending,
            errorMessage: failure.message,
          ),
        );
      },
      (message) {
        emit(
          ChatLoaded(
            messages: [...currentState.messages, message],
            isSending: currentState.isSending,
          ),
        );
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
            isSending: currentState.isSending,
            errorMessage: failure.message,
          ),
        );

        return false;
      },
      (message) {
        emit(
          ChatLoaded(
            messages: [...currentState.messages, message],
            isSending: currentState.isSending,
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

  void _subscribeToConversationStatus(String conversationId) {
    conversationStatusRealtimeDataSource.subscribe(
      conversationId: conversationId,
      onStatusChanged: _onConversationStatusChanged,
    );
  }

  void _onConversationStatusChanged({
    required String userId,
    required DateTime? lastDeliveredAt,
    required DateTime? lastReadAt,
  }) {
    final currentUser = authRepository.getCurrentUser();

    if (currentUser == null) {
      return;
    }

    // We only care about the other participant's row.
    if (userId == currentUser.id) {
      return;
    }

    _otherLastDeliveredAt = lastDeliveredAt;
    _otherLastReadAt = lastReadAt;

    final currentState = state;

    if (currentState is! ChatLoaded) {
      return;
    }

    emit(
      ChatLoaded(
        messages: currentState.messages,
        isSending: currentState.isSending,
      ),
    );
  }

  void _onMessageInserted(MessageModel model) {
    final currentState = state;

    if (currentState is! ChatLoaded) {
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
      ChatLoaded(
        messages: [...currentState.messages, message],
        isSending: currentState.isSending,
      ),
    );

    final currentUser = authRepository.getCurrentUser();

    if (currentUser != null && message.senderId != currentUser.id) {
      markConversationAsRead(conversationId: message.conversationId);
    }
  }

  void _onMessageUpdated(MessageModel model) {
    final currentState = state;

    if (currentState is! ChatLoaded) {
      return;
    }

    final updatedMessage = model.toEntity();

    final messages = currentState.messages.map((message) {
      if (message.id == updatedMessage.id) {
        return updatedMessage;
      }

      return message;
    }).toList();

    emit(ChatLoaded(messages: messages, isSending: currentState.isSending));
  }

  void _onMessageDeleted(String messageId) {
    final currentState = state;

    if (currentState is! ChatLoaded) {
      return;
    }

    final messages = currentState.messages
        .where((message) => message.id != messageId)
        .toList();

    emit(ChatLoaded(messages: messages, isSending: currentState.isSending));
  }

  MessageStatus? getMessageStatus({required MessageEntity message}) {
    final currentUser = authRepository.getCurrentUser();

    if (currentUser == null) {
      return null;
    }

    // Status is only displayed for our own messages.
    if (message.senderId != currentUser.id) {
      return null;
    }

    // Seen has priority over delivered.
    if (_otherLastReadAt != null &&
        !message.createdAt.isAfter(_otherLastReadAt!)) {
      return MessageStatus.seen;
    }

    // Delivered has priority over sent.
    if (_otherLastDeliveredAt != null &&
        !message.createdAt.isAfter(_otherLastDeliveredAt!)) {
      return MessageStatus.delivered;
    }

    return MessageStatus.sent;
  }

  @override
  Future<void> close() async {
    await messageRealtimeDataSource.unsubscribe();
    await conversationStatusRealtimeDataSource.unsubscribe();

    return super.close();
  }
}
