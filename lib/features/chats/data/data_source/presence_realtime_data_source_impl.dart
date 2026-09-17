import 'dart:developer';

import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/features/chats/data/data_source/presence_realtime_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PresenceRealtimeDataSourceImpl implements PresenceRealtimeDataSource {
  PresenceRealtimeDataSourceImpl();

  final SupabaseClient supabase = getIt<SupabaseClient>();

  RealtimeChannel? _channel;

  @override
  Future<void> subscribe({
    required String userId,
    required void Function(String userId) onUserOnline,
    required void Function(String userId) onUserOffline,
  }) async{
    await unsubscribe();

    _channel = supabase.channel('global_presence');

    _channel!
        .onPresenceSync((payload) {
          final state = _channel!.presenceState();

          for (final presence in state) {
            for (final user in presence.presences) {
              final id = user.payload['user_id'] as String;
              log('Presence sync online event: $id');

              onUserOnline(id);
            }
          }
        })
        .onPresenceJoin((payload) {
          for (final presence in payload.newPresences) {
            final id = presence.payload['user_id'] as String;
            log('Presence join online event: $id');

            onUserOnline(id);
          }
        })
        .onPresenceLeave((payload) {
          for (final presence in payload.leftPresences) {
            final id = presence.payload['user_id'] as String;
            log('Presence offline event: $id');

            onUserOffline(id);
          }
        })
        .subscribe((status, error) async {
          if (status == RealtimeSubscribeStatus.subscribed) {
            await _channel!.track({'user_id': userId});
          }
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
