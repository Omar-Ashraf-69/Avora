class MessageStatusModel {
  const MessageStatusModel({
    this.lastDeliveredAt,
    this.lastReadAt,
  });

  final DateTime? lastDeliveredAt;
  final DateTime? lastReadAt;

  factory MessageStatusModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return MessageStatusModel(
      lastDeliveredAt: json['last_delivered_at'] == null
          ? null
          : DateTime.parse(
              json['last_delivered_at'] as String,
            ),
      lastReadAt: json['last_read_at'] == null
          ? null
          : DateTime.parse(
              json['last_read_at'] as String,
            ),
    );
  }
}