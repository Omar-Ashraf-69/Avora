import 'package:avora/features/chats/data/models/conversation_preview_model.dart';
import 'package:avora/features/profile/data/models/profile_model.dart';

abstract class ConversationRemoteDataSource {
  Future<String> createDirectConversation({required String otherUserId});

  Future<List<ConversationPreviewModel>> getConversations();

  Future<ProfileModel> getOtherParticipant({
  required String conversationId,
});
}
