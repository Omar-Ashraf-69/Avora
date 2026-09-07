import 'package:avora/features/chats/domain/use_case/get_conversations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({
    required this.getConversationsUseCase,
  }) : super(const ChatsInitial());

  final GetConversationsUseCase getConversationsUseCase;

  Future<void> loadConversations() async {
    emit(const ChatsLoading());

    final result = await getConversationsUseCase();

    result.fold(
      (failure) {
        emit(
          ChatsFailure(
            message: failure.message,
          ),
        );
      },
      (conversations) {
        emit(
          ChatsLoaded(
            conversations: conversations,
          ),
        );
      },
    );
  }
}