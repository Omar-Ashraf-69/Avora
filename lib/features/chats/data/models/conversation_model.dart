import '../../domain/entities/conversation_entity.dart';

class ConversationModel {
  const ConversationModel({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final ConversationType type;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ConversationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ConversationModel(
      id: json['id'] as String,
      type: _conversationTypeFromString(
        json['type'] as String,
      ),
      createdAt: DateTime.parse(
        json['created_at'] as String,
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] as String,
      ),
    );
  }

  ConversationEntity toEntity() {
    return ConversationEntity(
      id: id,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static ConversationType _conversationTypeFromString(
    String value,
  ) {
    switch (value) {
      case 'direct':
        return ConversationType.direct;
      case 'group':
        return ConversationType.group;
      default:
        throw FormatException(
          'Unknown conversation type: $value',
        );
    }
  }
}