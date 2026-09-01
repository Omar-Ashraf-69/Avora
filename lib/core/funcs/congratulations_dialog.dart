import 'package:avora/core/constants/assets.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<void> congratulationsDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      
      return AlertDialog(
        backgroundColor: Colors.white,
        icon: Image.asset(
          Assets.imagesPngsPersonAvatar,
          width: 200.w,
          height: 200.h,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).congratulations,
              style: TextStyles.bold28.copyWith(color: AppColors.mainBlue),
            ),
            verticalSpace(12),
            Text(
              S.of(context).your_account_has_been_created,
              style: TextStyles.regular16,
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            LoadingAnimationWidget.newtonCradle(
              color: AppColors.mainBlue,
              size: 85.sp,
            ),
            verticalSpace(12),
          ],
        ),
      );
    },
  );
}
