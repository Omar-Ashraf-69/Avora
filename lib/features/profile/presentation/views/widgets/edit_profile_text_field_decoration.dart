  import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

InputDecoration editProfileTextFieldDecoration(
    BuildContext context,
    String hintText,
    String labelText, [
    bool? readOnly = false,
  ]) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyles.regular16.copyWith(color: AppColors.lightGray),
      labelText: labelText,
      filled: true,
      fillColor: AppColors.lightWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: readOnly ?? false
          ? null
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.mainBlue, width: 2),
            ),
    );
  }