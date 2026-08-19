import 'package:avora/core/constants/app_durations.dart';
import 'package:avora/core/helper/extenstions.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/features/auth/presentation/views/widgets/login_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = context.isKeyboardOpen;

    return AnimatedPadding(
      duration: AppDurations.fast,
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.only(
        top: isKeyboardOpen ? 40.h : 190.h,
      ),
      child: Column(
        children: [
          AnimatedScale(
            duration: AppDurations.fast,
            curve: Curves.easeOutCubic,
            scale: isKeyboardOpen ? .65 : 1,
            child: const LoginLogo(),
          ),

          SizedBox(
            height: isKeyboardOpen ? 24.h : 56.h,
          ),

          AnimatedOpacity(
            duration: AppDurations.fast,
            opacity: isKeyboardOpen ? .7 : 1,
            child: Text(
              title,
              style: TextStyles.bold23,
            ),
          ),
        ],
      ),
    );
  }
}