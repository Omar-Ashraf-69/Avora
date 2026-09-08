import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/chats/domain/entities/conversation_entity.dart';
import 'package:avora/features/chats/domain/entities/conversation_preview_entity.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({super.key, required this.conversation});
  final ConversationPreviewEntity conversation;

  @override
  Widget build(BuildContext context) {
    final currentUserId = getIt<AuthRepository>().getCurrentUser()?.id;
    final isLastMessageFromMe =
        conversation.lastMessageSenderId == currentUserId;

    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundColor: AppColors.lightGray,
            child: Icon(Icons.person, size: 40.h, color: AppColors.lightWhite),
          ),
          Positioned(
            right: 4.w,
            bottom: 4.h,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CircleAvatar(
                radius: 5.r,
                backgroundColor: AppColors.mainBlue,
              ),
            ),
          ),
        ],
      ),
      horizontalTitleGap: 4.w,
      title: Text(
        conversation.title,
        style: TextStyles.semiBold16,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: _buildLastMessagePreview(),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            conversation.lastMessageAt?.toLocalTimeLabel(context) ?? '',
            style: TextStyles.regular13.copyWith(color: AppColors.gray),
          ),
          verticalSpace(4),
          if (conversation.unreadCount > 0)
            CircleAvatar(
              radius: 12.r,
              backgroundColor: AppColors.mainBlue,
              child: Text(
                '${conversation.unreadCount}',
                style: TextStyles.bold13.copyWith(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLastMessagePreview() {
    final lastMessageType = conversation.lastMessageType;

    if (lastMessageType == MessageType.image) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          conversation.lastMessageSenderId ==
                  getIt<AuthRepository>().getCurrentUser()?.id
              ? Text('You:', style: TextStyles.regular13)
              : const SizedBox.shrink(),
          Icon(Icons.photo_outlined, size: 17.sp, color: AppColors.gray),
          horizontalSpace(4),
          Text('Photo', style: TextStyles.regular13),
        ],
      );
    }

    final lastMessage = conversation.lastMessage;

    if (lastMessage == null || lastMessage.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      conversation.lastMessageSenderId ==
              getIt<AuthRepository>().getCurrentUser()?.id
          ? 'You: $lastMessage'
          : lastMessage,
      style: TextStyles.regular13,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
