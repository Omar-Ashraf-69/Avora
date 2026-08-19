import 'package:avora/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

InputDecoration get counterInputDecortaion {
  return InputDecoration(
    counterText: '',
    filled: true,
    fillColor: AppColors.lighterGray,
    contentPadding: EdgeInsets.zero,
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
