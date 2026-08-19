import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/full_screen_image.dart';
import 'package:avora/features/chat/data/models/chat_message_model.dart';
import 'package:avora/features/chat/presentation/views/widgets/message_meta.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Align(
      alignment: isMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * .78,
        ),
        padding: message.isImage
            ? EdgeInsets.all(AppPadding.extraSmall)
            : const EdgeInsets.fromLTRB(12, 8, 8, 6),
        decoration: BoxDecoration(
          color: isMe ? AppColors.mainBlue : AppColors.lightWhite,
          borderRadius: BorderRadiusDirectional.only(
            topStart: const Radius.circular(16),
            topEnd: const Radius.circular(16),
            bottomStart: Radius.circular(isMe ? 16 : 4),
            bottomEnd: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (message.isImage) {
      return _buildImageMessage(context);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            message.text ?? '',
            style: TextStyles.regular15.copyWith(
              color: message.isMe ? Colors.white : AppColors.darkBlue,
            ),
          ),
        ),
        const SizedBox(width: 8),
        MessageMeta(message: message),
      ],
    );
  }

  Widget _buildImageMessage(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * .6;
    final height = width * .75;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenImage(imageUrl: message.imageUrl!),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: message.imageUrl!,
          width: width,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(width: width, height: height, color: Colors.white),
          ),
          errorWidget: (context, url, error) =>
              const Icon(Icons.broken_image_outlined),
        ),
      ),
    );
  }
}
