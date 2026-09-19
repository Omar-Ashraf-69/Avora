import 'package:avora/features/chats/domain/entities/message_entity.dart';

sealed class GroupChatState {
  const GroupChatState();
}

final class GroupChatInitial extends GroupChatState {
  const GroupChatInitial();
}

final class GroupChatLoading extends GroupChatState {
  const GroupChatLoading();
}

final class GroupChatLoaded extends GroupChatState {
  const GroupChatLoaded({
    required this.messages,
    this.isSending = false,
    this.errorMessage,
  });

  final List<MessageEntity> messages;
  final bool isSending;
  final String? errorMessage;
}

final class GroupChatFailure extends GroupChatState {
  const GroupChatFailure({
    required this.message,
  });

  final String message;
}