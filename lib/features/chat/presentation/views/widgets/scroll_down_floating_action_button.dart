import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScrollDownFloatingActionButton extends StatelessWidget {
  const ScrollDownFloatingActionButton({
    super.key,
    required this._showScrollToBottomButton,
    this.onPressed,
    this.unreadMessagesCount = 0,
  });
  final int unreadMessagesCount;
  final bool _showScrollToBottomButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 18.w,
      bottom: 18.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedScale(
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
          if (unreadMessagesCount > 0)
            Positioned(
              left: -2.w,
              top: -2.h,
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mainBlue,
                ),
                constraints: BoxConstraints(minWidth: 22.w, minHeight: 22.h),
                child: Center(
                  child: Text(
                    unreadMessagesCount > 99 ? '99+' : '$unreadMessagesCount',
                    style: TextStyles.semiBold13.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
