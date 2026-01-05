import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/auth/logout_response.dart';
import 'package:gamelog/features/auth/controllers/logout_controller.dart';
import 'package:gamelog/features/auth/views/login_screen.dart';
import 'package:gamelog/features/home/controllers/load_game_controller.dart';
import 'package:gamelog/features/home/controllers/load_trend_statistics_controller.dart';
import 'package:gamelog/features/notifications/views/notifications_screen.dart';
import 'package:gamelog/core/data/models/statistics/retrieve_statistics_response.dart';
import 'package:gamelog/features/reviews/views/review_history_screen.dart';
import 'package:gamelog/features/statistics/views/statistics_screen.dart';

import '../../../core/data/providers/sockets/notifications/socket_providers.dart';
import '../../../core/domain/entities/game.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/presentation/failure_handler.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/app_game_card.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_graph.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_skeleton_loader.dart';
import '../../reviews/views/game_screen.dart';

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
      description: detailed.description,
      released: detailed.released,
      rating: detailed.rating,
      backgroundImageAdditional: detailed.backgroundImageAdditional,
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
    if (!mounted) return;
    setState(() => isLoading = true);

    await ref.read(loadGameControllerProvider.notifier).searchGame(query);

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  Future<void> performLogout() async {
    final user = ref.read(currentUserProvider);
    ref.read(globalLoadingProvider.notifier).state = true;

    if (user == null) return;
    if (user.email == null) return;

    await ref.read(logoutControllerProvider.notifier).logout(user.email!);
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
    Future.microtask(() => _connectSocket());
  }

  void _connectSocket() {
    final socketController = ref.read(socketControllerProvider.notifier);
    final currentUser = ref.read(currentUserProvider.notifier).state;
    final socketState = ref.watch(socketControllerProvider);

    if (currentUser == null) return;

    if (!socketState.isConnected) {
      socketController.connect(
        usuario: dotenv.env['USUARIO_NOTI']!,
        contrasenia: dotenv.env['CONTRASENIA_NOTI']!,
        idJugador: currentUser.idPlayer.toString(),
      );

      socketController.suscribirBroadcast();
    }
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
    if (!mounted) return;
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (!mounted) return;
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
    if (!mounted) return;
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) async {
          if (!mounted) return;
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
          if (!mounted) return;
          handleFailure(context: context, error: error);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final socketState = ref.watch(socketControllerProvider);
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
            setState(() => notFoundTrendStatistics = true);
            ref.read(globalLoadingProvider.notifier).state = false;

            handleFailure(context: context, error: error);
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppModuleTitle(title: l10n.appName),
        elevation: 0,
        leading: AppIconButton(
          icon: Icons.logout,
          onPressed: () => performLogout(),
        ),
        actions: [
          Icon(socketState.isConnected ? Icons.wifi : Icons.wifi_off),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationsScreen()),
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
              AppModuleTitle(
                title: 'Visita el juego mas resenado de la semana',
              ),

              if (notFoundTrendStatistics)
                Text('no se eonctro el mas resenado')
              else if (mergedGames.isEmpty)
                const AppSkeletonLoader(
                  height: 200,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                )
              else
                AppGameCard(
                  name: mergedGames.first.name,
                  imageUrl:
                      mergedGames.first.backgroundImage ??
                      'https://picsum.photos/800/450',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameScreen(game: mergedGames.first),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 8.0),

              if (notFoundTrendStatistics)
                Text('noo se encontraron estadiscicas')
              else if (mergedGames.isEmpty)
                const AppSkeletonLoader(
                  height: 297,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                )
              else
                AppGraph(
                  games: mergedGames,
                  title: 'Top de la semanna',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => StatisticsScreen()),
                    );
                  },
                ),
              const SizedBox(height: 12.0),

              AppModuleButton(
                icon: Icons.history,
                label: l10n.reviewHistoryTitle,
                onPressed: () {
                  final user = ref.read(currentUserProvider);

                  if (user == null) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ReviewHistoryScreen(idPlayerToSearch: user.idPlayer),
                    ),
                  );
                },

                color: Colors.grey,
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}
