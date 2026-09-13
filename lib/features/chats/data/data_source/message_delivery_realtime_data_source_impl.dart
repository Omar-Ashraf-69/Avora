import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/chats/data/data_source/message_delivery_realtime_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageDeliveryRealtimeDataSourceImpl
    implements MessageDeliveryRealtimeDataSource {
  MessageDeliveryRealtimeDataSourceImpl();

  final SupabaseClient supabase = getIt<SupabaseClient>();

  RealtimeChannel? _channel;

  @override
  void subscribe({
    required void Function({
      required String conversationId,
      required String senderId,
    })
    onMessageReceived,
  }) {
    unsubscribe();

    _channel = supabase
        .channel('global_message_delivery')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          callback: (payload) {
            final record = payload.newRecord;

            final conversationId = record['conversation_id'] as String;
            final senderId = record['sender_id'] as String;

            onMessageReceived(
              conversationId: conversationId,
              senderId: senderId,
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