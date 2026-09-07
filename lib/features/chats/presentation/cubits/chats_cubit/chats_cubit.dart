import 'package:avora/features/chats/domain/use_case/get_conversations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({
    required this.getConversationsUseCase,
    required this.supabaseClient,
  }) : super(const ChatsInitial());

  final GetConversationsUseCase getConversationsUseCase;
  final SupabaseClient supabaseClient;

  RealtimeChannel? _channel;
  Future<void> loadConversations({bool showLoading = true}) async {
    if (showLoading) {
      emit(const ChatsLoading());
    }

    final result = await getConversationsUseCase();

    result.fold(
      (failure) {
        if (showLoading) {
          emit(ChatsFailure(message: failure.message));
        }
      },
      (conversations) {
        emit(ChatsLoaded(conversations: conversations));
      },
    );
  }

  void subscribeToConversationUpdates() {
    _channel = supabaseClient
        .channel('chats_conversations')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (_) {
            loadConversations(showLoading: false);
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'messages',
          callback: (_) {
            loadConversations(showLoading: false);
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'messages',
          callback: (_) {
            loadConversations(showLoading: false);
          },
        ).onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'conversation_members',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'user_id',
          value: supabaseClient.auth.currentUser?.id ?? '',
        ),
        callback: (_) {
          loadConversations(showLoading: false);
        },
      )
        .subscribe();
  }

  @override
  Future<void> close() async {
    if (_channel != null) {
      await supabaseClient.removeChannel(_channel!);
      _channel = null;
    }

    return super.close();
  }
}
