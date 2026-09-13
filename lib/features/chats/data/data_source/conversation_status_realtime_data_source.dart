abstract class ConversationStatusRealtimeDataSource {
  void subscribe({
    required String conversationId,
    required void Function({
      required String userId,
      required DateTime? lastDeliveredAt,
      required DateTime? lastReadAt,
    }) onStatusChanged,
  });

  Future<void> unsubscribe();
}