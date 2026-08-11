import 'package:avora/features/chats/presentation/views/chats_view.dart';
import 'package:avora/features/home/presentation/views/widgets/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          ChatsView(),
          Center(child: Text('Groups View')),
          Center(child: Text('Settings View')),
        ],
      ),
      // floatingActionButton: _currentIndex == 2
      //     ? null
      //     : CustomFloatingActionButton(icon: Icons.add, onPressed: () {}),
      bottomNavigationBar: HomeBottomNavigationBar(
        currentIndex: _currentIndex,
        onDestinationSelected: _onNavigationItemTapped,
      ),
    );
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
}
