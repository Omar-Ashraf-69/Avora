
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class ChatsSearchField extends StatelessWidget {
  const ChatsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: S.of(context).search,
        hintStyle: TextStyles.regular16.copyWith(color: AppColors.lightGray),
        contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.normal),
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: AppPadding.small),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedSearch01,
            color: AppColors.lightGray,
            size: 28.r,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 12,
          minHeight: 12,
        ),
        filled: true,

        fillColor: AppColors.lightWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: AppColors.mainBlue, width: 0.75),
        ),
      ),
    );
  }
}
