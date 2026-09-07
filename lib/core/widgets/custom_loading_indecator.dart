
import 'package:avora/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingIndecator extends StatelessWidget {
  const CustomLoadingIndecator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.beat(
        color: AppColors.mainBlue,
        size: 50.r,
      ),
    );
  }
}
