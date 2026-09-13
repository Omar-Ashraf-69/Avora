class ConversationMessageStatus {
  const ConversationMessageStatus({
    required this.lastDeliveredAt,
    required this.lastReadAt,
  });

  final DateTime? lastDeliveredAt;
  final DateTime? lastReadAt;
}