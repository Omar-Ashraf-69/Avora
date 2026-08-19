import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, this.onPressed, this.color});
  final String label ;
final Function()? onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          iconColor:color ?? AppColors.mainBlue,
          backgroundColor:color ?? AppColors.mainBlue,
          enableFeedback: false,
          elevation: 0.0,
          foregroundColor: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.normal),
          child: Text(label, style: TextStyles.bold16),
        ),
      ),
    );
  }
}
