import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,

      text: TextSpan(
        style: TextStyle(color: AppColors.darkBlue),
        children: [
          TextSpan(
            text: S.of(context).by_siging_up,
            style: TextStyles.regular13.copyWith(height: 1.5),
          ),
          TextSpan(
            text: S.of(context).terms_and_conditions,
            style: TextStyles.semiBold13,
          ),
          TextSpan(
            text: S.of(context).and,
            style: TextStyles.regular13.copyWith(height: 1.5),
          ),
          TextSpan(
            text: S.of(context).privacy_policy,
            style: TextStyles.semiBold13,
          ),
        ],
      ),
    );
  }
}
