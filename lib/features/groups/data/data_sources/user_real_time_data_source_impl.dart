import 'dart:developer';

import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/groups/data/data_sources/user_real_time_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRealtimeDataSourceImpl implements UserRealtimeDataSource {
  UserRealtimeDataSourceImpl();

  final SupabaseClient supabase = getIt<SupabaseClient>();

  RealtimeChannel? _channel;

 @override
Future<void> subscribe({
  required String userId,
  required void Function(String conversationId) onGroupAdded,
}) async {
  await unsubscribe();

  final topic = 'user:$userId:events';

  log('════════ USER REALTIME DEBUG ════════');
  log('👤 userId: $userId');
  log('📡 topic: $topic');

  _channel = supabase.channel(
    topic,
    opts: const RealtimeChannelConfig(
      private: true,
    ),
  );

  _channel!
      .onBroadcast(
        event: 'group_added',
        callback: (payload) {
          log('🔥🔥🔥 BROADCAST RECEIVED 🔥🔥🔥');
          log('📦 payload: $payload');

          final broadcastPayload = payload['payload'];

          if (broadcastPayload is! Map) {
            log('⚠️ Invalid broadcast payload');
            return;
          }

          final conversationId =
              broadcastPayload['conversation_id'] as String?;

          if (conversationId == null) {
            log('⚠️ Missing conversation_id');
            return;
          }

          log('🆕 GROUP ADDED: $conversationId');

          onGroupAdded(conversationId);
        },
      )
      .subscribe((status, error) {
        log('📡 USER REALTIME STATUS: $status');
        log('📡 USER REALTIME ERROR: $error');
      });
}
  @override
  Future<void> unsubscribe() async {
    final channel = _channel;

    if (channel == null) return;

    await supabase.removeChannel(channel);
    _channel = null;
  }
}
