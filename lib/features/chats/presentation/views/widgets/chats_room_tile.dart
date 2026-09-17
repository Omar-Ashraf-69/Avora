import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/chats/domain/entities/conversation_preview_entity.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/generated/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({super.key, required this.conversation});
  final ConversationPreviewEntity conversation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _buildAvatar(),
      horizontalTitleGap: 4.w,
      title: Text(
        conversation.title,
        style: TextStyles.semiBold16,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: _buildLastMessagePreview(context),
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

  Widget _buildAvatar() {
    final avatarUrl = conversation.avatarUrl;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundColor: AppColors.lightGray,
          child: ClipOval(
            child: avatarUrl != null && avatarUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: avatarUrl,
                    width: 64.w,
                    height: 64.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return SizedBox(
                        width: 64.w,
                        height: 64.h,
                        child: Center(
                          child: SizedBox(
                            width: 20.r,
                            height: 20.r,
                            child: LoadingAnimationWidget.discreteCircle(
                              color: AppColors.mainBlue,
                              size: 20.r,
                            ),
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.person,
                        size: 42.sp,
                        color: AppColors.lightWhite,
                      );
                    },
                  )
                : Icon(Icons.person, size: 42.sp, color: AppColors.lightWhite),
          ),
        ),
        Positioned(
          right: 2.w,
          bottom: 2.h,
          child: Container(
            padding: EdgeInsets.all(2.r),
            decoration: const BoxDecoration(
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
    );
  }

  String _buildTextPreview(String message) {
    final lines = message
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    if (lines.isEmpty) return '';
    final firstLine = lines.first;
    return lines.length > 1 ? '$firstLine ...' : firstLine;
  }

  Widget _buildLastMessagePreview(BuildContext context) {
    final lastMessageType = conversation.lastMessageType;

    // New conversation — no messages yet.
    if (conversation.lastMessageAt == null) {
      return Text(
        S.of(context).start_a_conversation,
        style: TextStyles.regular13.copyWith(color: AppColors.gray),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    if (lastMessageType == MessageType.image) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          conversation.lastMessageSenderId ==
                  getIt<AuthRepository>().getCurrentUser()?.id
              ? Text(S.of(context).you, style: TextStyles.regular13)
              : const SizedBox.shrink(),
          Icon(Icons.photo_outlined, size: 17.sp, color: AppColors.gray),
          horizontalSpace(4),
          Text(S.of(context).photo, style: TextStyles.regular13),
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
          ? '${S.of(context).you}: ${_buildTextPreview(lastMessage)}'
          : _buildTextPreview(lastMessage),
      style: TextStyles.regular13,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
