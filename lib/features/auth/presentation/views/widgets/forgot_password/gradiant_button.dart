import 'package:avora/core/helper/spacing.dart';
import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GradientButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.mainBlue, Color(0xFF7048E8)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF635BFF).withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 25.w,
                    height: 25.h,
                    child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: AppColors.mainBlue,
                      rightDotColor: const Color(0xFF7048E8),
                      size: 25,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.of(context).send_rest_link,
                        style: TextStyles.bold16.copyWith(color: Colors.white),
                      ),
                      horizontalSpace(8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 24.r,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
