import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';

class OtpResendSection extends StatelessWidget {
  const OtpResendSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).resend_code_in, style: TextStyles.semiBold16),
        GestureDetector(
          onTap: () {
            // Handle resend code action
          },
          child: Text(
            "00:30",
            style: TextStyles.semiBold16.copyWith(color: AppColors.mainBlue),
          ),
        ),
      ],
    );
  }
}
