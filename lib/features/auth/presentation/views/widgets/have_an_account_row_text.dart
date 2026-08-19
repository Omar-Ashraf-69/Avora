import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:flutter/material.dart';

class HaveAnAccountRowText extends StatelessWidget {
  const HaveAnAccountRowText({super.key, required this.title, required this.actionText, this.onTap});

  final String title;
  final String actionText;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyles.semiBold16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.small),
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              actionText,
              style: TextStyles.bold16.copyWith(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}