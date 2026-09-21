import 'package:avora/core/di/dependecny_injection.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/images/app_avatar.dart';
import 'package:avora/features/auth/domain/repos/auth_repo.dart';
import 'package:avora/features/groups/domain/entities/group_details_entity.dart';
import 'package:avora/generated/l10n.dart';
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
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: AppPadding.small),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      title: Row(
        children: [
          _buildAvatar(),

          horizontalSpace(10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  group?.name ?? S.of(context).loading_user,
                  maxLines: 1,
                  style: TextStyles.semiBold16,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(2),

                Text(
                  participantNames.length > 3 ? '$subtitle...' : subtitle,
                  maxLines: 1,
                  style: TextStyles.regular13.copyWith(color: AppColors.gray),
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
