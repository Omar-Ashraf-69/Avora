part of 'chat_cubit.dart';

sealed class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {
  const ChatInitial();
}

final class ChatLoading extends ChatState {
  const ChatLoading();
}

final class ChatLoaded extends ChatState {
  const ChatLoaded({
    required this.messages,
    this.errorMessage,
  });

  final List<MessageEntity> messages;
  final String? errorMessage;
}

final class ChatSending extends ChatState {
  const ChatSending({
    required this.messages,
  });

  final List<MessageEntity> messages;
}

final class ChatFailure extends ChatState {
  const ChatFailure({
    required this.message,
  });

  final String message;
}