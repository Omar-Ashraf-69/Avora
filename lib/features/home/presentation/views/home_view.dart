import 'package:avora/core/themes/app_colors.dart';
import 'package:avora/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final PageController _pageController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavigationItemTapped(int index) {
    if (_currentIndex == index) return;

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          Center(child: Text('Chats View')),
          Center(child: Text('Groups View')),
          Center(child: Text('Settings View')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: () {},
        child: const Icon(Icons.chat_rounded, color: AppColors.lightWhite),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            border: Border.all(color: AppColors.lighterGray, width: 0.6),
          ),
          child: NavigationBar(
            height: 70.h,
            backgroundColor: Colors.transparent,
            elevation: 0,

            selectedIndex: _currentIndex,

            onDestinationSelected: _onNavigationItemTapped,

            indicatorColor: AppColors.mainBlue.withValues(alpha: 0.16),

            overlayColor: WidgetStateProperty.all(Colors.transparent),

            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
              states,
            ) {
              {
                return TextStyles.semiBold16.copyWith(
                  color: states.contains(WidgetState.selected)
                      ? AppColors.mainBlue
                      : AppColors.gray,
                );
              }
            }),
            animationDuration: const Duration(milliseconds: 300),

            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.chat, color: AppColors.mainBlue),
                icon: Icon(Icons.chat_outlined, color: Colors.grey),
                label: 'Chats',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.groups, color: AppColors.mainBlue),
                icon: Icon(Icons.groups_outlined, color: Colors.grey),
                label: 'Groups',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.settings, color: AppColors.mainBlue),
                icon: Icon(Icons.settings_outlined, color: Colors.grey),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
