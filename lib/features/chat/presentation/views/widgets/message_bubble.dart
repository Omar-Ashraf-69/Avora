import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_image.dart';
import 'package:avora/features/chat/presentation/views/widgets/message_meta.dart';
import 'package:avora/features/chats/data/data_source/image_storage_data_source.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.imageStorageDataSource,
  });

  final MessageEntity message;
  final bool isMe;
  final ImageStorageDataSource imageStorageDataSource;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * .78,
        ),
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 6),
        decoration: BoxDecoration(
          color: isMe ? AppColors.mainBlue : AppColors.lightWhite,
          borderRadius: BorderRadiusDirectional.only(
            topStart: const Radius.circular(16),
            topEnd: const Radius.circular(16),
            bottomStart: Radius.circular(isMe ? 16 : 4),
            bottomEnd: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: message.type == MessageType.text
            ? _buildTextMessage()
            : _buildImageMessage(context),
      ),
    );
  }

  Widget _buildTextMessage() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            message.content ?? '',
            style: TextStyles.regular15.copyWith(
              color: isMe ? Colors.white : AppColors.darkBlue,
            ),
          ),
        ),
        const SizedBox(width: 8),
        MessageMeta(message: message, isMe: isMe),
      ],
    );
  }

  Widget _buildImageMessage(BuildContext context) {
    final imagePath = message.imageUrl;

    if (imagePath == null || imagePath.isEmpty) {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width * .6,
        height: MediaQuery.sizeOf(context).width * .6 * .8,
        child: Center(child: Icon(Icons.broken_image_outlined)),
      );
    }
    final width = MediaQuery.sizeOf(context).width * .6;
    final height = width * .8;
    return ChatImage(
      path: imagePath,
      width: width,
      height: height,
      imageStorageDataSource: imageStorageDataSource,
      content: message.content,
      isMe: isMe,
    );
  }
}
