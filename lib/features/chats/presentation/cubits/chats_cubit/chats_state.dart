import 'package:avora/features/chats/domain/entities/conversation_preview_entity.dart';

sealed class ChatsState {
  const ChatsState();
}

final class ChatsInitial extends ChatsState {
  const ChatsInitial();
}

final class ChatsLoading extends ChatsState {
  const ChatsLoading();
}

final class ChatsLoaded extends ChatsState {
  const ChatsLoaded({
    required this.conversations,
  });

  final List<ConversationPreviewEntity> conversations;
}

final class ChatsFailure extends ChatsState {
  const ChatsFailure({
    required this.message,
  });

  final String message;
}