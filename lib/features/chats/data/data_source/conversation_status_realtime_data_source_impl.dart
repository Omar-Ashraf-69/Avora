import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/chats/data/data_source/conversation_status_realtime_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationStatusRealtimeDataSourceImpl
    implements ConversationStatusRealtimeDataSource {
  ConversationStatusRealtimeDataSourceImpl();

  final supabase = getIt<SupabaseClient>();

  RealtimeChannel? _channel;

  @override
  void subscribe({
    required String conversationId,
    required void Function({
      required String userId,
      required DateTime? lastDeliveredAt,
      required DateTime? lastReadAt,
    })
    onStatusChanged,
  }) {
    unsubscribe();

    _channel = supabase
        .channel('conversation_status_$conversationId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'conversation_members',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'conversation_id',
            value: conversationId,
          ),
          callback: (payload) {
            final record = payload.newRecord;

            final lastDeliveredAt = record['last_delivered_at'] == null
                ? null
                : DateTime.parse(record['last_delivered_at'] as String);

            final lastReadAt = record['last_read_at'] == null
                ? null
                : DateTime.parse(record['last_read_at'] as String);

            onStatusChanged(
              lastDeliveredAt: lastDeliveredAt,
              lastReadAt: lastReadAt,
              userId: record['user_id'] as String,
            );
          },
        )
        .subscribe();
  }

  @override
  Future<void> unsubscribe() async {
    final channel = _channel;

    if (channel == null) return;

    await supabase.removeChannel(channel);

    _channel = null;
  }
}
