import 'package:avora/core/error/exceptions.dart';
import 'package:avora/core/services/auth/auth_remote_data_source_repo.dart';
import 'package:avora/core/services/database/data_base_service.dart';
import '../models/conversation_model.dart';
import 'conversation_remote_data_source.dart';

class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  ConversationRemoteDataSourceImpl({
    required this.databaseService,
    required this.authRemoteDataSource,
  });

  final DatabaseService databaseService;
  final AuthRemoteDataSourceRepo authRemoteDataSource;

  static const String _conversationsTable = 'conversations';
  static const String _membersTable = 'conversation_members';

  @override
  Future<String> createDirectConversation({required String otherUserId}) async {
    final result = await databaseService.rpc(
      functionName: 'create_direct_conversation',
      params: {'p_other_user_id': otherUserId},
    );

    return result as String;
  }

  @override
  Future<List<ConversationModel>> getUserConversations() async {
    final user = authRemoteDataSource.getCurrentUser();

    if (user == null) {
      throw const CustomException(message: 'User is not authenticated.');
    }

    final members = await databaseService.get(
      table: _membersTable,
      filters: {'user_id': user.id},
    );

    if (members.isEmpty) {
      return [];
    }

    final conversationIds = members
        .map((member) => member['conversation_id'] as String)
        .toList();

    final conversations = <ConversationModel>[];

    for (final conversationId in conversationIds) {
      final data = await databaseService.getById(
        table: _conversationsTable,
        id: conversationId,
      );

      if (data != null) {
        conversations.add(ConversationModel.fromJson(data));
      }
    }

    return conversations;
  }
}
