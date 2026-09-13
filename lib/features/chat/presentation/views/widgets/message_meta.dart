import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class MessageMeta extends StatelessWidget {
  const MessageMeta({
    super.key,
    required this.message,
    required this.isMe,
    this.status,
  });

  final MessageEntity message;
  final bool isMe;
  final MessageStatus? status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
        
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(
          message.createdAt.toLocalTimeLabel(context),
          style: TextStyles.regular09.copyWith(
            color: isMe ? Colors.white70 : AppColors.gray,
          ),
        ),

        if (isMe) ...[horizontalSpace(3), _buildStatusIcon()],
      ],
    );
  }

  Widget _buildStatusIcon() {
    return switch (status) {
      MessageStatus.seen => const Icon(
        Icons.done_all,
        size: 16,
        color: AppColors.lighterBlue,
      ),
      MessageStatus.delivered => const Icon(
        Icons.done_all,
        size: 16,
        color: Colors.white70,
      ),
      MessageStatus.sent => const Icon(
        Icons.done,
        size: 16,
        color: Colors.white70,
      ),
      null => const Icon(Icons.access_time, size: 14, color: Colors.white70),
    };
  }
}
