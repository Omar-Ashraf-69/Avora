import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(height: 1.h, color: Colors.grey.shade300),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(S.of(context).or, style: TextStyles.semiBold13),
        ),
        Expanded(
          child: Container(height: 1.h, color: Colors.grey.shade300),
        ),
      ],
    );
  }
}
