part of 'conversation_cubit.dart';

sealed class ConversationState {
  const ConversationState();
}

final class ConversationInitial extends ConversationState {
  const ConversationInitial();
}

final class ConversationLoading extends ConversationState {
  const ConversationLoading();
}

final class DirectConversationCreated extends ConversationState {
  const DirectConversationCreated({required this.conversationId});

  final String conversationId;
}

final class ConversationFailure extends ConversationState {
  const ConversationFailure({required this.message});

  final String message;
}
