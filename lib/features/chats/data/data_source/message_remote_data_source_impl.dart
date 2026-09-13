import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/services/database/data_base_service.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/chats/data/data_source/message_remote_data_source.dart';
import 'package:avora/features/chats/data/models/message_model.dart';
import 'package:avora/features/chats/domain/entities/conversation_message_status.dart';
import 'package:avora/generated/l10n.dart';

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  const MessageRemoteDataSourceImpl({
    required this.databaseService,
    required this.authRepository,
  });

  final DatabaseService databaseService;
  final AuthRepository authRepository;

  @override
  Future<List<MessageModel>> getMessages({
    required String conversationId,
  }) async {
    final result = await databaseService.get(
      table: 'messages',
      filters: {'conversation_id': conversationId},
    );

    final models = result.map((json) => MessageModel.fromJson(json)).toList();

    models.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return models;
  }

  @override
  Future<MessageModel> sendTextMessage({
    required String conversationId,
    required String content,
  }) async {
    final user = authRepository.getCurrentUser();

    if (user == null) {
      throw CustomException(message: S.current.user_not_found);
    }

    final result = await databaseService.insert(
      table: 'messages',
      data: {
        'conversation_id': conversationId,
        'sender_id': user.id,
        'type': 'text',
        'content': content.trim(),
      },
    );

    return MessageModel.fromJson(result);
  }

  @override
  Future<MessageModel> sendImageMessage({
    required String conversationId,
    required String messageId,
    required String imagePath,
    String? content,
  }) async {
    final user = authRepository.getCurrentUser();

    if (user == null) {
      throw CustomException(message: S.current.not_authenticated);
    }

    final result = await databaseService.insert(
      table: 'messages',
      data: {
        'id': messageId,
        'conversation_id': conversationId,
        'sender_id': user.id,
        'type': 'image',
        'image_url': imagePath,
        'content': content,
      },
    );

    return MessageModel.fromJson(result);
  }

  @override
  Future<void> markConversationAsRead({required String conversationId}) async {
    await databaseService.rpc(
      functionName: 'mark_conversation_as_read',
      params: {'p_conversation_id': conversationId},
    );
  }

  @override
  Future<void> markConversationAsDelivered({
    required String conversationId,
  }) async {
    await databaseService.rpc(
      functionName: 'mark_conversation_as_delivered',
      params: {'p_conversation_id': conversationId},
    );
  }

  @override
  @override
  Future<ConversationMessageStatus> getOtherParticipantMessageStatus({
    required String conversationId,
  }) async {
    final result = await databaseService.rpc(
      functionName: 'get_other_participant_message_status',
      params: {'p_conversation_id': conversationId},
    );

    if (result == null) {
      throw CustomException(message: S.current.unexpected_error);
    }

    final data = result is List
        ? result.firstOrNull
        : result as Map<String, dynamic>;

    if (data == null) {
      throw CustomException(message: S.current.unexpected_error);
    }

    return ConversationMessageStatus(
      lastDeliveredAt: data['last_delivered_at'] == null
          ? null
          : DateTime.parse(data['last_delivered_at'] as String),
      lastReadAt: data['last_read_at'] == null
          ? null
          : DateTime.parse(data['last_read_at'] as String),
    );
  }

  @override
  Future<void> markPendingMessagesAsDelivered() async {
    await databaseService.rpc(
      functionName: 'mark_pending_messages_as_delivered',
    );
  }
}
