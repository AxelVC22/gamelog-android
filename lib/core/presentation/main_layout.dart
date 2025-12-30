import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gamelog/features/reviews/views/games_screen.dart';
import 'package:gamelog/features/users/views/my_profile_screen.dart';
import '../../features/auth/state/auth_state.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/home/views/home_screen.dart';
import '../../features/follows/views/social_screen.dart';

import '../constants/app_colors.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({super.key});

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  int _index = 0;

  final screens = const [
    HomeScreen(),
    GamesScreen(),
    SocialScreen(),
    MyProfileScreen(),
  ];

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
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.people),
            label: 'Social',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person),
            label: 'Personal',
          ),
        ],
      ),
    );
  }
}
