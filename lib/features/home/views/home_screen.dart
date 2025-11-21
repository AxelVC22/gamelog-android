import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/notifications/views/notifications_screen.dart';
import 'package:gamelog/features/review_management/views/review_history_screen.dart';
import 'package:gamelog/features/social/views/social_screen.dart';
import 'package:gamelog/features/user_management/views/my_profile_screen.dart';
import 'package:gamelog/features/user_management/views/search_profile_screen.dart';

import '../../../l10n/app_localizations.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../auth/providers/auth_providers.dart';
import '../../review_management/views/search_game_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.red,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.search),
            label: 'Search',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.newspaper),
            label: 'Feed',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.perm_identity),
            label: 'Personal',
          ),
        ],
        onTap: (index) {
          // Handle button tap
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: AppIconButton(
          icon: Icons.logout,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SocialScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyProfileScreen()),
              );
            },
          ),
          SizedBox(width: 8), // Espaciado al borde
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/images/isotipo.png', height: 150.0),
              const SizedBox(height: 48.0),
              Center(child: AppModuleTitle(title: l10n.appName)),
              Center(
                child: AppModuleTitle(
                  title: l10n.welcomeMessage(
                    ref.watch(currentUserProvider)!.name,
                  ),
                ),
              ),

              AppModuleButton(
                icon: Icons.videogame_asset,
                label: l10n.searchGameTitle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchGameScreen()),
                  );
                },
                color: Colors.green,
              ),
              const SizedBox(height: 8.0),

              AppModuleButton(
                icon: Icons.person_search_outlined,
                label: l10n.searchProfileTitle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchProfileScreen()),
                  );
                },
                color: Colors.blue,
              ),

              const SizedBox(height: 8.0),

              AppModuleButton(
                icon: Icons.history,
                label: l10n.reviewHistoryTitle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ReviewHistoryScreen()),
                  );
                },
                color: Colors.brown,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
