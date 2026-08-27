import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatarPicker extends StatelessWidget {
  const ProfileAvatarPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70.sp,
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.person, size: 50, color: AppColors.lightWhite),
        ),
        Positioned(
          bottom: 0,
          right: 14.w,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(AppPadding.extraSmall),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.mainBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.edit, size: 20.h, color: AppColors.lightWhite),
            ),
          ),
        ),
      ],
    );
  }
}
