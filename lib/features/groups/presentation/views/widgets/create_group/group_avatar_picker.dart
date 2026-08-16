import 'dart:io';

import 'package:avora/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

class GroupAvatarPicker extends StatefulWidget {
  const GroupAvatarPicker({super.key});

  @override
  State<GroupAvatarPicker> createState() => GroupAvatarPickerState();
}

class GroupAvatarPickerState extends State<GroupAvatarPicker> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 70.r,
          height: 70.r,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lighterGray,
          ),
          child: image != null
              ? Image.file(File(image!.path), fit: BoxFit.cover)
              : HugeIcon(
                  icon: HugeIcons.strokeRoundedUserGroup,
                  size: 36.r,
                  color: AppColors.gray,
                ),
        ),

        Positioned(
          right: -2.w,
          bottom: -2.h,
          child: Material(
            color: AppColors.mainBlue,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () async {
                final picker = ImagePicker();
                // Pick an image.
                image = await picker.pickImage(source: ImageSource.gallery);
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.all(7.r),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedCamera01,
                  size: 15.r,
                  color: AppColors.lightWhite,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
