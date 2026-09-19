import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/widgets/images/app_avatar.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/groups/domain/entities/group_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GroupChatRoomAppBar extends StatelessWidget {
  const GroupChatRoomAppBar({super.key, required this.group});

  final GroupDetailsEntity? group;

  @override
  Widget build(BuildContext context) {
    if (group == null) {
      return const SizedBox.shrink();
    }

    final currentUserId = getIt<AuthRepository>().getCurrentUser()?.id;

    final participantNames = group!.members
        .where((member) => member.userId != currentUserId)
        .map((member) => member.name)
        .toList();

    final subtitle = participantNames.take(3).join(', ');

    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          _buildAvatar(),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(group!.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(
                  participantNames.length > 3 ? '$subtitle...' : subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return AppAvatar(
      imageUrl: group?.avatarUrl,
      radius: 22.r,
      placeholder: Center(
        child: SizedBox(
          width: 14.r,
          height: 14.r,
          child: LoadingAnimationWidget.discreteCircle(
            color: AppColors.mainBlue,
            size: 14.r,
          ),
        ),
      ),
      fallbackIcon: Icon(
        Icons.person,
        size: 25.sp,
        color: AppColors.lightWhite,
      ),
    );
  }
}
