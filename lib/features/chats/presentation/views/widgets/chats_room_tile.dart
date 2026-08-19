import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({super.key});

  @override
  Widget build(BuildContext context) {
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
      horizontalTitleGap: 2.w,
      title: Text(
        "John Doe",
        style: TextStyles.semiBold16,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "Hey I miss you 😊",
        style: TextStyles.regular13,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "2:30 PM",
            style: TextStyles.regular13.copyWith(color: AppColors.gray),
          ),
          verticalSpace(4),
          CircleAvatar(
            radius: 12.r,
            backgroundColor: AppColors.mainBlue,
            child: Text(
              "2",
              style: TextStyles.bold13.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
