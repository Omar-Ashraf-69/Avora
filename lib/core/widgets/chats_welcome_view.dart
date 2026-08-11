import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/constants/assets.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeViewColumn extends StatelessWidget {
  const WelcomeViewColumn({super.key, required this.actionText, required this.message});
  final String actionText;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesPngsSplashImage,
              width: MediaQuery.of(context).size.width * .7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Text(
                "Welcome 👋",
                style: TextStyles.bold32.copyWith(color: AppColors.mainBlue),
              ),
            ),
            Text(
              message,
              style: TextStyles.regular15,
              textAlign: TextAlign.center,
            ),
            verticalSpace(AppSpacing.md),
            CustomButton(label: actionText, onPressed: () {}),
            verticalSpace(AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
