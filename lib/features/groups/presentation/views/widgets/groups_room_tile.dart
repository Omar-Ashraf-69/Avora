
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsRoomTile extends StatelessWidget {
  const GroupsRoomTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        radius: 32.r,
        backgroundColor: AppColors.lightGray,
        child: Icon(
          Icons.person,
          size: 40.h,
          color: AppColors.lightWhite,
        ),
      ),
      horizontalTitleGap: 2.w,
      title: Text(
        "My Beloved Family ❤️",
        style: TextStyles.semiBold16,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "It's a group for my family",
        style: TextStyles.regular13,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "2:30 PM",
            style: TextStyles.regular13.copyWith(
              color: AppColors.gray,
            ),
          ),
          verticalSpace(4),
          CircleAvatar(
            radius: 12.r,
            backgroundColor: AppColors.mainBlue,
            child: Text(
              "2",
              style: TextStyles.bold13.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
