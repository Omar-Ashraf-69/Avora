import 'package:avora/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScrollDownFloatingActionButton extends StatelessWidget {
  const ScrollDownFloatingActionButton({
    super.key,
    required this._showScrollToBottomButton,
    this.onPressed,
  });

  final bool _showScrollToBottomButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 18.w,
      bottom: 18.h,
      child: AnimatedScale(
        scale: _showScrollToBottomButton ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton.small(
          elevation: 0,
          shape: const CircleBorder(),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.mainBlue,
          onPressed: onPressed,
          child: const Icon(Icons.keyboard_double_arrow_down_outlined),
        ),
      ),
    );
  }
}
