import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.mainBlue, Color(0xFF725CFF)],
              ),
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 22.r,
            ),
          ),

          horizontalSpace(16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).check_your_inbox, style: TextStyles.bold13),
                verticalSpace(6),
                Text(
                  S.of(context).we_will_send_you_a_link_to_reset_your_password,
                  style: TextStyles.semiBold11.copyWith(
                    color: AppColors.lightGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
