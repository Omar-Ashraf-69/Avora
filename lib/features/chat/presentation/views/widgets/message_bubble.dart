import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/chat/presentation/views/widgets/chat_image.dart';
import 'package:avora/features/chat/presentation/views/widgets/message_meta.dart';
import 'package:avora/features/chats/data/data_source/image_storage_data_source.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/chats/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            bottomStart: Radius.circular(isMe ? 8 : 2),
            bottomEnd: Radius.circular(isMe ? 2 : 8),
          ),
        ),
        child: message.type == MessageType.text
            ? _buildTextMessage(context)
            : _buildImageMessage(context),
      ),
    );
  }

  Widget _buildTextMessage(BuildContext context) {
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
        MessageMeta(
          message: message,
          isMe: isMe,
          status: context.read<ChatCubit>().getMessageStatus(message: message),
        ),
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
      message: message,
      isMe: isMe,
    );
  }
}
