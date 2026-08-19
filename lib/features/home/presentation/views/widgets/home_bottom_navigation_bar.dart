import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:avora/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          border: Border.all(color: AppColors.lighterGray, width: 0.6),
        ),
        child: NavigationBar(
          height: 70.h,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIndex: currentIndex,
          onDestinationSelected: onDestinationSelected,
          indicatorColor: AppColors.mainBlue.withValues(alpha: 0.16),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            return TextStyles.semiBold16.copyWith(
              color: states.contains(WidgetState.selected)
                  ? AppColors.mainBlue
                  : AppColors.gray,
            );
          }),
          animationDuration: const Duration(milliseconds: 300),
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.chat, color: AppColors.mainBlue),
              icon: Icon(Icons.chat_outlined, color: AppColors.gray),
              label: S.of(context).chats,
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.groups, color: AppColors.mainBlue),
              icon: Icon(Icons.groups_outlined, color: AppColors.gray),
              label: S.of(context).groups,
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings, color: AppColors.mainBlue),
              icon: Icon(Icons.settings_outlined, color: AppColors.gray),
              label: S.of(context).settings,
            ),
          ],
        ),
      ),
    );
  }
}
