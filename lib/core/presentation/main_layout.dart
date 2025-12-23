import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:gamelog/features/review_management/views/search_game_screen.dart';
import 'package:gamelog/features/user_management/views/my_profile_screen.dart';

import '../../features/home/views/home_screen.dart';
import '../../features/social/views/social_screen.dart';
import '../constants/app_colors.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _index = 0;

  final screens = const [HomeScreen(), SearchGameScreen(), SocialScreen(), MyProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.primary,
        color: AppColors.surface,
        buttonBackgroundColor: AppColors.surfaceAlt,
        index: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          CurvedNavigationBarItem(child: Icon(Icons.search), label: 'Search'),
          CurvedNavigationBarItem(child: Icon(Icons.people), label: 'Social'),

          CurvedNavigationBarItem(
            child: Icon(Icons.perm_identity),
            label: 'Personal',
          ),
        ],
      ),
    );
  }
}
