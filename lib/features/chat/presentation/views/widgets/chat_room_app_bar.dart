import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/features/profile/domain/entities/profile_entity.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

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
          CircleAvatar(
            radius: 20,
            backgroundImage: profile?.avatarUrl != null
                ? NetworkImage(profile!.avatarUrl!)
                : null,
            child: profile?.avatarUrl == null ? const Icon(Icons.person) : null,
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.5,
                child: Text(
                  profile?.name ?? 'Loading User',

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
}
