abstract class UserRealtimeDataSource {
  Future<void> subscribe({
    required String userId,
    required void Function(String conversationId) onGroupAdded,
  });

  Future<void> unsubscribe();
}