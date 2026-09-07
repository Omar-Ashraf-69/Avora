import 'package:avora/features/chats/data/models/message_model.dart';

abstract class MessageRemoteDataSource {
  Future<List<MessageModel>> getMessages({
    required String conversationId,
  });

  Future<MessageModel> sendTextMessage({
    required String conversationId,
    required String content,
  });
}