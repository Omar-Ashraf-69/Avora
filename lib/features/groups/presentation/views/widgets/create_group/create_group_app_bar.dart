
import 'package:avora/core/constants/assets.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/core/themes/padding.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CreateGroupAppBar extends StatelessWidget {
  const CreateGroupAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: AppPadding.small),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      title: Row(
        children: [
          SvgPicture.asset(
            Assets.imagesSvgsAppIcon,
            height: 44.h,
            width: 44.w,
            colorFilter: const ColorFilter.mode(
              AppColors.mainBlue,
              BlendMode.srcIn,
            ),
          ),
          Text(S.of(context).create_a_new_group, style: TextStyles.bold23),
        ],
      ),
      elevation: 0,
    );
  }
}