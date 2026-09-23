abstract class PresenceRealtimeDataSource {
  Future<void> subscribe({
    required String userId,
    required void Function(String userId) onUserOnline,
    required void Function(String userId) onUserOffline,
  });

Future<void> unsubscribe();
}