import '../models/conversation_model.dart';

abstract class ConversationRemoteDataSource {
  Future<String> createDirectConversation({
    required String otherUserId,
  });

  Future<List<ConversationModel>> getUserConversations();
}