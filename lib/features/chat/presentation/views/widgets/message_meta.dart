import 'package:avora/core/funcs/formate_data_time.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/chat/data/enums/message_status.dart';
import 'package:avora/features/chat/data/models/chat_message_model.dart';
import 'package:flutter/material.dart';

class MessageMeta extends StatelessWidget {
  const MessageMeta({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatMessageTime(message.createdAt,context),
          style: TextStyles.regular09.copyWith(
            color: message.isMe ? Colors.white70 : AppColors.gray,
          ),
        ),
        if (message.isMe) ...[const SizedBox(width: 3), _buildStatusIcon()],
      ],
    );
  }

  Widget _buildStatusIcon() {
    return switch (message.status) {
      MessageStatus.seen => const Icon(
        Icons.done_all,
        size: 16,
        color: AppColors.lighterBlue,
      ),
      MessageStatus.delivered => const Icon(
        Icons.done_all,
        size: 16,
        color: AppColors.lightWhite,
      ),
      MessageStatus.sent => const Icon(
        Icons.done,
        size: 16,
        color: AppColors.lightWhite,
      ),
      null => const Icon(
        Icons.watch_later_outlined,
        size: 16,
        color: AppColors.lightWhite,
      ),
    };
  }
}
