import 'package:avora/core/constants/app_spacing.dart';
import 'package:avora/core/constants/assets.dart';
import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class WelcomeViewColumn extends StatelessWidget {
  const WelcomeViewColumn({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            verticalSpace(AppSpacing.xl),
            Image.asset(
              Assets.imagesPngsSplashImage,
              width: MediaQuery.of(context).size.width * .6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Text(
                "${S.of(context).welcome} 👋",
                style: TextStyles.bold32.copyWith(color: AppColors.mainBlue),
              ),
            ),
            Text(
              message,
              style: TextStyles.regular15,
              textAlign: TextAlign.center,
            ),
            verticalSpace(AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
