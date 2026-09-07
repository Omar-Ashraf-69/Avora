import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/services/database/data_base_service.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/chats/data/data_source/message_remote_data_source.dart';
import 'package:avora/features/chats/data/models/message_model.dart';
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
      filters: {
        'conversation_id': conversationId,
      },
    );

    final models = result
        .map((json) => MessageModel.fromJson(json))
        .toList();

    models.sort(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );

    return models;
  }

  @override
  Future<MessageModel> sendTextMessage({
    required String conversationId,
    required String content,
  }) async {
    final user = authRepository.getCurrentUser();

    if (user == null) {
      throw CustomException(
  message: S.current.user_not_found,
);
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
Future<void> markConversationAsRead({
  required String conversationId,
}) async {
  await databaseService.rpc(
    functionName: 'mark_conversation_as_read',
    params: {
      'p_conversation_id': conversationId,
    },
  );
}
}