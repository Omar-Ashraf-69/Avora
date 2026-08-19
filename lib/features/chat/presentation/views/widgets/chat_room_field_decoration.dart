import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:flutter/material.dart';

InputDecoration chatRoomFieldDecoration(
  String hintText, {
  VoidCallback? onEmojiPressed,
  VoidCallback? onImagePressed,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyles.regular15.copyWith(color: AppColors.lightGray),

    suffixIcon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onEmojiPressed,
          borderRadius: BorderRadius.circular(20),
          child: const Padding(
            padding: EdgeInsets.only(left: AppPadding.small),
            child: Icon(
              Icons.emoji_emotions_outlined,
              color: AppColors.mainBlue,
            ),
          ),
        ),

        InkWell(
          onTap: onImagePressed,
          borderRadius: BorderRadius.circular(20),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.small),
            child: Icon(Icons.image_outlined, color: AppColors.mainBlue),
          ),
        ),
      ],
    ),

    filled: true,
    fillColor: AppColors.lightWhite,

    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppPadding.normal,
      vertical: AppPadding.small,
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: const BorderSide(color: AppColors.mainBlue, width: .8),
    ),
  );
}
