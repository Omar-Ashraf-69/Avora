import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:avora/generated/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatRoomAppBar extends StatelessWidget {
  const ChatRoomAppBar({
    super.key,
    required this.context,
    required this.profile,
  });

  final BuildContext context;
  final ProfileEntity? profile;

  @override
  Widget build(BuildContext context) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.5,
                child: Text(
                  profile?.name ?? S.of(context).loading_user,
                  style: TextStyles.semiBold16,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              verticalSpace(2),
              Text(
                // ignore: unrelated_type_equality_checks
                profile?.id == 0
                    ? S.of(context).online
                    : profile?.about ??
                          "${S.of(context).last_seen} ${S.of(context).recently}",
                style: TextStyles.regular13.copyWith(
                  // ignore: unrelated_type_equality_checks
                  color: profile?.id == 0 ? AppColors.mainBlue : AppColors.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final avatarUrl = profile?.avatarUrl;
    return CircleAvatar(
      radius: 22.r,
      backgroundColor: AppColors.lightGray,
      child: ClipOval(
        child: avatarUrl != null && avatarUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: avatarUrl,
                width: 44.r,
                height: 44.r,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return SizedBox(
                    width: 40.r,
                    height: 40.r,
                    child: Center(
                      child: SizedBox(
                        width: 14.r,
                        height: 14.r,
                        child: LoadingAnimationWidget.discreteCircle(
                          color: AppColors.mainBlue,
                          size: 14.r,
                        ),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(
                    Icons.person,
                    size: 25.sp,
                    color: AppColors.lightWhite,
                  );
                },
              )
            : Icon(Icons.person, size: 25.sp, color: AppColors.lightWhite),
      ),
    );
  }
}
