abstract class MessageDeliveryRealtimeDataSource {
  Future<void> subscribe({
    required void Function({
      required String conversationId,
      required String senderId,
    })
    onMessageReceived,
  });

  Future<void> unsubscribe();
}