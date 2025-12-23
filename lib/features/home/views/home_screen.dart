import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/constants/app_colors.dart';
import 'package:gamelog/features/auth/models/logout_response.dart';
import 'package:gamelog/features/auth/providers/logout_controller.dart';
import 'package:gamelog/features/auth/views/login_screen.dart';
import 'package:gamelog/features/home/providers/load_game_controller.dart';
import 'package:gamelog/features/home/providers/load_trend_statistics_controller.dart';
import 'package:gamelog/features/notifications/views/notifications_screen.dart';
import 'package:gamelog/features/statistics/models/retrieve_statistics_response.dart';
import 'package:gamelog/features/review_management/views/review_history_screen.dart';
import 'package:gamelog/features/social/views/social_screen.dart';
import 'package:gamelog/features/statistics/views/statistics_screen.dart';
import 'package:gamelog/features/user_management/views/my_profile_screen.dart';
import 'package:gamelog/features/user_management/views/search_profile_screen.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/helpers/failure_handler.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_graph.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_skeleton_loader.dart';
import '../../auth/providers/auth_providers.dart';
import '../../review_management/views/search_game_screen.dart';

final searchResultProvider = StateProvider.autoDispose<List<Game?>>(
  (ref) => [],
);

final retrieveResultsProvider = StateProvider.autoDispose<List<Game>>(
  (ref) => [],
);

final mergedGamesProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(retrieveResultsProvider);
  final detailedGames = ref.watch(searchResultProvider);

  final detailedById = {for (final game in detailedGames) game?.id: game};

  return games.map((game) {
    final detailed = detailedById[game.id];
    if (detailed == null) return game;

    return game.copyWith(
      name: detailed.name,
      backgroundImage: detailed.backgroundImage ?? '',
    );
  }).toList();
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ProviderSubscription _searchGameSub;
  late final ProviderSubscription _reviewHistorySub;
  bool isLoading = false;
  bool notFoundTrendStatistics = false;

  Future<void> _searchGame(String query) async {
    setState(() => isLoading = true);

    await ref.read(loadGameControllerProvider.notifier).searchGame(query);

    setState(() => isLoading = false);
  }

  Future<void> performLogout() async {
    final email = ref.read(currentUserProvider)?.email;

    await ref.read(logoutControllerProvider.notifier).logout(email!);
  }

  @override
  void initState() {
    super.initState();

    _searchGameSub = ref.listenManual<AsyncValue<Game?>>(
      loadGameControllerProvider,
      _onSearchGameChanged,
    );

    _reviewHistorySub = ref
        .listenManual<AsyncValue<RetrieveStatisticsResponse?>>(
          loadTrendStatisticsControllerProvider,
          _onRetrieveTrendStatisticsChanged,
        );

    Future.microtask(() => _search());
  }

  Future<void> _search() async {
    if (!mounted) return;

    ref.read(searchResultProvider.notifier).state = [];
    ref.read(retrieveResultsProvider.notifier).state = [];

    await ref
        .read(loadTrendStatisticsControllerProvider.notifier)
        .loadTrendStatistics();
  }

  @override
  void dispose() {
    _reviewHistorySub.close();
    _searchGameSub.close();
    super.dispose();
  }

  void _onSearchGameChanged(
      AsyncValue<Game?>? previous,
      AsyncValue<Game?> next,
      ) {
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (response == null) return;

          final notifier = ref.read(searchResultProvider.notifier);
          notifier.state = [...notifier.state, response];
        },
        error: (error, __) {},
      );
    }
  }

  void _onRetrieveTrendStatisticsChanged(
      AsyncValue<RetrieveStatisticsResponse?>? previous,
      AsyncValue<RetrieveStatisticsResponse?> next,
      ) async {
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) async {
          ref.read(globalLoadingProvider.notifier).state = false;

          if (response == null) {
            return;
          }

          if (response.games.isEmpty) {
            setState(() => notFoundTrendStatistics = true);
          }

          for (int i = 0; i < response.games.length; i++) {
            await _searchGame(response.games[i].name);
          }

          ref.read(retrieveResultsProvider.notifier).state = response.games;
        },
        error: (error, __) {
          handleFailure(context: context, error: error);
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final mergedGames = ref.watch(mergedGamesProvider);

    ref.listen<AsyncValue<LogoutResponse?>>(logoutControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;
            if (response == null) return;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
          error: (error, stack) {
            ref.read(globalLoadingProvider.notifier).state = false;

            final msg = error is Failure
                ? (error.serverMessage ?? l10n.byKey(error.code))
                : error.toString();

            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
            });
          },
        );
      }

      if (next.isLoading) {
        // ref.read(globalLoadingProvider.notifier).state = true;
      }
    });

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.primary,
        color: AppColors.surface,
        buttonBackgroundColor: AppColors.surfaceAlt,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          CurvedNavigationBarItem(child: Icon(Icons.search), label: 'Search'),
          CurvedNavigationBarItem(
            child: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          CurvedNavigationBarItem(child: Icon(Icons.newspaper), label: 'Feed'),
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
        elevation: 0,
        leading: AppIconButton(
          icon: Icons.logout,
          onPressed: () => performLogout(),
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
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 24.0),
              if (mergedGames.isNotEmpty)
                AppGraph(
                  games: mergedGames,
                  title: 'Top de la semanna',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => StatisticsScreen()),
                    );
                  },
                )
              else if (!notFoundTrendStatistics)
                const AppSkeletonLoader(
                  height: 290,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ) ,
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
                    MaterialPageRoute(
                      builder: (_) => ReviewHistoryScreen(
                        idPlayerToSearch: ref
                            .read(currentUserProvider.notifier)
                            .state!
                            .idPlayer,
                      ),
                    ),
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
