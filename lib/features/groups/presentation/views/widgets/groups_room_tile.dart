import 'package:avora/core/helper/extenstions.dart';
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
      contentPadding: const EdgeInsets.all(0),
      leading: AppAvatar(
        imageUrl: group.avatarUrl,
        radius: 26,
        fallbackIcon: const Icon(Icons.group, color: AppColors.lightWhite),
      ),
      horizontalTitleGap: 2.w,
      title: Text(
        group.name,
        style: TextStyles.semiBold16,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _buildLastMessage(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: _buildTrailing(),
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

  Widget? _buildTrailing() {
    if (group.unreadCount == 0) {
      return null;
    }

    return CircleAvatar(
      radius: 10.r,
      backgroundColor: AppColors.mainBlue,
      child: Text(
        group.unreadCount > 99 ? '99+' : group.unreadCount.toString(),
        style: TextStyles.bold13.copyWith(color: Colors.white),
      ),
    );
  }
}
