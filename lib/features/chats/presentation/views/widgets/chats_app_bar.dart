import 'package:avora/core/constants/assets.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChatsAppBar extends StatelessWidget {
  const ChatsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.imagesSvgsAppIcon,
          height: 60.h,
          width: 60.w,
          colorFilter: const ColorFilter.mode(
            AppColors.mainBlue,
            BlendMode.srcIn,
          ),
        ),
        Text("Avora", style: TextStyles.semiBold19),
      ],
    );
  }
}