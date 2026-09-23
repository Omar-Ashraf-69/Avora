import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/chats/data/data_source/message_realtime_data_source.dart';
import 'package:avora/features/chats/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageRealtimeDataSourceImpl
    implements MessageRealtimeDataSource {
  MessageRealtimeDataSourceImpl();

  final supabaseService = getIt<SupabaseClient>();

  RealtimeChannel? _messagesChannel;
  RealtimeChannel? _conversationsChannel;

  /// Conversations currently belonging to the user.
  ///
  /// This is intentionally mutable because new groups can be added
  /// after the conversations realtime channel has already subscribed.
  Set<String> _conversationIds = {};

  // ---------------------------------------------------------------------------
  // CURRENT CHAT MESSAGES
  // ---------------------------------------------------------------------------

  @override
  Future<void> subscribeToMessages({
    required String conversationId,
    required void Function(MessageModel message) onMessageInserted,
    required void Function(MessageModel message) onMessageUpdated,
    required void Function(String messageId) onMessageDeleted,
  }) async {
    await unsubscribeFromMessages();

    _messagesChannel = supabaseService
        .channel('conversation_messages_$conversationId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'conversation_id',
            value: conversationId,
          ),
          callback: (payload) {
            final message = MessageModel.fromJson(
              payload.newRecord,
            );

            onMessageInserted(message);
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'conversation_id',
            value: conversationId,
          ),
          callback: (payload) {
            final message = MessageModel.fromJson(
              payload.newRecord,
            );

            onMessageUpdated(message);
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'conversation_id',
            value: conversationId,
          ),
          callback: (payload) {
            final messageId =
                payload.oldRecord['id'] as String;

            onMessageDeleted(messageId);
          },
        )
        .subscribe((status, error) {
          print('📡 CHAT REALTIME STATUS: $status');
          print('📡 CHAT REALTIME ERROR: $error');
        });
  }

  // ---------------------------------------------------------------------------
  // GROUPS LIST / CONVERSATIONS
  // ---------------------------------------------------------------------------

  @override
  Future<void> subscribeToConversations({
    required List<String> conversationIds,
    required void Function(MessageModel message) onMessageInserted,
    required void Function(MessageModel message) onMessageUpdated,
    required void Function(String messageId) onMessageDeleted,
  }) async {
    await unsubscribeFromConversations();

    _conversationIds = conversationIds.toSet();

    _conversationsChannel = supabaseService
        .channel('group_conversations_realtime')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final conversationId =
                payload.newRecord['conversation_id'] as String;

            if (!_conversationIds.contains(conversationId)) {
              return;
            }

            final message = MessageModel.fromJson(
              payload.newRecord,
            );

            onMessageInserted(message);
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final conversationId =
                payload.newRecord['conversation_id'] as String;

            if (!_conversationIds.contains(conversationId)) {
              return;
            }

            final message = MessageModel.fromJson(
              payload.newRecord,
            );

            onMessageUpdated(message);
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final conversationId =
                payload.oldRecord['conversation_id'] as String;

            if (!_conversationIds.contains(conversationId)) {
              return;
            }

            final messageId =
                payload.oldRecord['id'] as String;

            onMessageDeleted(messageId);
          },
        )
        .subscribe((status, error) {
          print('📡 GROUP REALTIME STATUS: $status');
          print('📡 GROUP REALTIME ERROR: $error');
        });
  }

  // ---------------------------------------------------------------------------
  // UPDATE CONVERSATION IDS
  // ---------------------------------------------------------------------------

  @override
  void updateConversationIds(List<String> conversationIds) {
    _conversationIds = conversationIds.toSet();

    print(
      '🔄 Realtime conversation IDs updated: '
      '${_conversationIds.length}',
    );
  }

  // ---------------------------------------------------------------------------
  // UNSUBSCRIBE CHAT
  // ---------------------------------------------------------------------------

  @override
  Future<void> unsubscribeFromMessages() async {
    final channel = _messagesChannel;

    if (channel == null) {
      return;
    }

    await supabaseService.removeChannel(channel);

    _messagesChannel = null;
  }

  // ---------------------------------------------------------------------------
  // UNSUBSCRIBE GROUPS
  // ---------------------------------------------------------------------------

  @override
  Future<void> unsubscribeFromConversations() async {
    final channel = _conversationsChannel;

    if (channel == null) {
      return;
    }

    await supabaseService.removeChannel(channel);

    _conversationsChannel = null;
  }

  // ---------------------------------------------------------------------------
  // UNSUBSCRIBE EVERYTHING
  // ---------------------------------------------------------------------------

  @override
  Future<void> unsubscribe() async {
    await Future.wait([
      unsubscribeFromMessages(),
      unsubscribeFromConversations(),
    ]);
  }
}