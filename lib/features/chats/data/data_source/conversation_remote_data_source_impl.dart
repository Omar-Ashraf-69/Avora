import 'package:avora/core/services/auth/auth_remote_data_source_repo.dart';
import 'package:avora/core/services/database/data_base_service.dart';
import 'package:avora/features/chats/data/models/conversation_preview_model.dart';
import 'conversation_remote_data_source.dart';

class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  ConversationRemoteDataSourceImpl({
    required this.databaseService,
    required this.authRemoteDataSource,
  });

  final DatabaseService databaseService;
  final AuthRemoteDataSourceRepo authRemoteDataSource;
  
  @override
  Future<String> createDirectConversation({required String otherUserId}) async {
    final result = await databaseService.rpc(
      functionName: 'create_direct_conversation',
      params: {'p_other_user_id': otherUserId},
    );

    return result as String;
  }

  @override
  Future<List<ConversationPreviewModel>> getConversations() async {
    final result = await databaseService.rpc(functionName: 'get_conversations');

    if (result is! List) {
      return [];
    }

    return result
        .map(
          (json) =>
              ConversationPreviewModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}
