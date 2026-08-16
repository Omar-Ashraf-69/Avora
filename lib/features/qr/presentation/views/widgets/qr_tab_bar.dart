import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

TabBar qrTabBar( TabController tabController) {
    return TabBar(
        controller: tabController,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyles.bold16,
        labelColor: AppColors.mainBlue,
        dividerColor: AppColors.lightBlue,
        indicatorColor: AppColors.mainBlue,
        unselectedLabelColor: AppColors.gray,
        tabs: const [
          Tab(text: 'My Code'),
          Tab(text: 'Scan Code'),
        ],
      );
  }
