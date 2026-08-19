

import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ScannedUserBottomSheet extends StatelessWidget {
  const ScannedUserBottomSheet({super.key, 
    required this.username,
    required this.phoneNumber,
    required this.onStartChatting,
  });

  final String username;
  final String phoneNumber;
  final VoidCallback onStartChatting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.medium,
        AppPadding.medium,
        AppPadding.medium,
        AppPadding.large,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            verticalSpace(24),

            CircleAvatar(
              radius: 42,
              backgroundColor: AppColors.lightBlue,
              child: Icon(Icons.person, size: 42, color: AppColors.mainBlue),
            ),

            verticalSpace(16),

            Text(
              username,
              style: TextStyles.bold23,
              textAlign: TextAlign.center,
            ),

            verticalSpace(6),

            Text(
              phoneNumber,
              style: TextStyles.regular16.copyWith(color: AppColors.gray),
            ),

            verticalSpace(24),

            Text(
              'You found this contact using their QR code.',
              style: TextStyles.regular13.copyWith(color: AppColors.lightGray),
              textAlign: TextAlign.center,
            ),

            verticalSpace(24),

            CustomButton(label: 'Start Chatting', onPressed: onStartChatting),

            verticalSpace(8),

            TextButton(
              onPressed: () => context.pop(),

              child: Text(
                'Cancel',
                style: TextStyles.semiBold16.copyWith(color: AppColors.gray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
