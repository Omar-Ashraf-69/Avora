
import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/chats/data/data_source/message_realtime_data_source.dart';
import 'package:avora/features/chats/data/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageRealtimeDataSourceImpl
    implements MessageRealtimeDataSource {
  MessageRealtimeDataSourceImpl();

  final  supabaseService = getIt<SupabaseClient>();

  RealtimeChannel? _channel;

  @override
  void subscribeToMessages({
    required String conversationId,
    required void Function(MessageModel message) onMessageInserted,
    required void Function(MessageModel message) onMessageUpdated,
    required void Function(String messageId) onMessageDeleted,
  }) {
    // Prevent multiple subscriptions.
    unsubscribe();

    _channel = supabaseService
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
            final messageId = payload.oldRecord['id'] as String;

            onMessageDeleted(messageId);
          },
        )
        .subscribe();
  }

  @override
  Future<void> unsubscribe() async {
    final channel = _channel;

    if (channel == null) return;

    await supabaseService.removeChannel(channel);

    _channel = null;
  }
}