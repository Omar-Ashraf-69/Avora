import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignButtonWidget extends StatelessWidget {
  const SignButtonWidget({
    super.key,
    required this.icon,
    required this.buttonLabel,
    this.onPressed,
  });
  final String icon;
  final String buttonLabel;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18.h),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: null,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xffDDDFDF)),
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(icon),
              Spacer(),
              Text(buttonLabel, style: TextStyles.bold16),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
