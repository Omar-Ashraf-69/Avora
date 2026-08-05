import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

InputDecoration customFieldDecoration(String title, {Icon? suffixIcon}) {
    return InputDecoration(
      hintText: title,
      hintStyle: TextStyles.regular16.copyWith(color: AppColors.lightGray),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.lightWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.mainBlue, width: 2),
      ),
    );
  }