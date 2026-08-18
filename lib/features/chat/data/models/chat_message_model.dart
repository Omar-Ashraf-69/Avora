import 'package:avora/features/chat/data/enums/message_status.dart';

class ChatMessage {
  const ChatMessage({
    this.text,
    required this.createdAt,
    required this.isMe,
    this.status,
    this.imageUrl,
  });

  final String? text;
  final DateTime createdAt;
  final bool isMe;
  final MessageStatus? status;
  final String? imageUrl;

  bool get isImage => imageUrl != null;
}

final List<ChatMessage> messages = [
  ChatMessage(
    text: 'Hey! How are you?',
    createdAt: DateTime.utc(2026, 8, 18, 7, 30),
    isMe: false,
  ),

  ChatMessage(
    text: 'I am good! How about you?',
    createdAt: DateTime.utc(2026, 8, 18, 7, 31),
    isMe: true,
    status: MessageStatus.seen,
  ),

  ChatMessage(
    text: 'Doing great 😊',
    createdAt: DateTime.utc(2026, 8, 18, 7, 32),
    isMe: false,
  ),

  ChatMessage(
    text: 'Are you free today?',
    createdAt: DateTime.utc(2026, 8, 18, 7, 33),
    isMe: true,
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQkUywIUXDjHSQJIaNHYVs08osgBpF5Ot-xmB_omyEZeeRP9Xug',
  ),

  ChatMessage(
    text: 'Amazing',
    createdAt: DateTime.utc(2026, 8, 18, 8, 59),
    isMe: false,
  ),

  ChatMessage(
    text: 'Check This Out',
    createdAt: DateTime.utc(2026, 8, 18, 9, 59),
    isMe: false,
    imageUrl:
        'https://i.swncdn.com/media/950w/via/images/2023/03/06/29698/29698-istockgetty-images-plusalexandrapp_source_file.webp',
  ),
];