import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/routing/app_routes.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/widgets/images/app_avatar.dart';
import 'package:avora/features/chats/domain/entities/message_entity.dart';
import 'package:avora/features/groups/domain/entities/group_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsRoomTile extends StatelessWidget {
  const GroupsRoomTile({super.key, required this.group});
  final GroupListItemEntity group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: AppAvatar(
        imageUrl: group.avatarUrl,
        radius: 28.r,
        fallbackIcon: const Icon(Icons.group, color: AppColors.lightWhite),
      ),
      horizontalTitleGap: 4.w,
      title: Text(
        group.name,
        style: TextStyles.semiBold16,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _buildLastMessage(),
        maxLines: 1,
        style: TextStyles.regular13.copyWith(color: AppColors.gray),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: _buildTrailing(context),
      onTap: () {
        context.pushNamed(
          AppRoutes.groupChatRoom,
          arguments: {'conversationId': group.conversationId},
        );
      },
    );
  }

  String _buildLastMessage() {
    if (group.lastMessageType == MessageType.image) {
      return '📷 Image';
    }

    return group.lastMessage ?? 'No messages yet';
  }

  Widget? _buildTrailing(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          group.lastMessageAt?.toLocalTimeLabel(context) ?? '',
          style: TextStyles.regular13.copyWith(color: AppColors.gray),
        ),
        verticalSpace(4),
        if (group.unreadCount > 0)
          CircleAvatar(
            radius: 12.r,
            backgroundColor: AppColors.mainBlue,
            child: Text(
              '${group.unreadCount}',
              style: TextStyles.bold13.copyWith(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
