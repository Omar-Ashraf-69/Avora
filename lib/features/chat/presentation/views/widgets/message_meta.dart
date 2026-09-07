import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class MessageMeta extends StatelessWidget {
  const MessageMeta({
    super.key,
    required this.message,
    required this.isMe,
  });

  final MessageEntity message;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message.createdAt.toLocalTimeLabel(context),
          style: TextStyles.regular09.copyWith(
            color: isMe ? Colors.white70 : AppColors.gray,
          ),
        ),
      
       // if (message.isMe) ...[horizontalSpace(3), _buildStatusIcon()],
      ],
    );
  }

  // Widget _buildStatusIcon() {
  //   return switch (message.status) {
  //     MessageStatus.seen => const Icon(
  //       Icons.done_all,
  //       size: 16,
  //       color: AppColors.lighterBlue,
  //     ),
  //     MessageStatus.delivered => const Icon(
  //       Icons.done_all,
  //       size: 16,
  //       color: AppColors.lightWhite,
  //     ),
  //     MessageStatus.sent => const Icon(
  //       Icons.done,
  //       size: 16,
  //       color: AppColors.lightWhite,
  //     ),
  //     null => const Icon(
  //       Icons.watch_later_outlined,
  //       size: 16,
  //       color: AppColors.lightWhite,
  //     ),
  //   };
  // }
}
