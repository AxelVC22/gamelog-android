import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/games/games_response.dart';
import 'package:gamelog/features/games/controllers/retrieve_favorite_games_controller.dart';
import 'package:gamelog/features/reviews/views/search_game_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/widgets/app_game_detailed_card.dart';
import 'package:gamelog/widgets/app_skeleton_loader.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/presentation/failure_handler.dart';
import '../../../widgets/app_filter_tab.dart';
import '../../../widgets/app_module_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../games/controllers/retrieve_pending_games_controller.dart';
import '../../statistics/controllers/search_game_controller.dart';
import 'game_screen.dart';

final searchFavoriteResultProvider = StateProvider.autoDispose<List<Game?>>(
  (ref) => [],
);

final searchPendingResultProvider = StateProvider.autoDispose<List<Game?>>(
      (ref) => [],
);

final retrieveResultsProvider = StateProvider.autoDispose<List<Game>>(
  (ref) => [],
);

final mergedFavoriteGamesProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(retrieveResultsProvider);
  final detailedGames = ref.watch(searchFavoriteResultProvider);

  final detailedById = {for (final game in detailedGames) game?.id: game};

  return games.map((game) {
    final detailed = detailedById[game.id];
    if (detailed == null) return game;

    return game.copyWith(
      name: detailed.name,
      backgroundImage: detailed.backgroundImage ?? '',
      description: detailed.description,
      backgroundImageAdditional: detailed.backgroundImageAdditional,
      rating: detailed.rating,
      released: detailed.released
    );
  }).toList();
});

final mergedPendingGamesProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(retrieveResultsProvider);
  final detailedGames = ref.watch(searchPendingResultProvider);

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

class GamesScreen extends ConsumerStatefulWidget {
  const GamesScreen({super.key});

  @override
  ConsumerState<GamesScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends ConsumerState<GamesScreen> {
  late final ProviderSubscription _searchGameSub;
  late final ProviderSubscription _retrieveFavoriteGameSub;
  late final ProviderSubscription _retrievePendingGameSub;
  bool isLoading = false;
  bool notFoundResults = false;
  bool showingFollowed = true;

  Future<void> _retrieveFavorite() async {
    if (!mounted) return;

    setState(() => isLoading = true);
    setState(() => notFoundResults = false);
    setState(() => showingFollowed = true);

    ref.read(retrieveResultsProvider.notifier).state = [];
    ref.read(searchFavoriteResultProvider.notifier).state = [];

    await ref
        .read(retrieveFavoriteGamesControllerProvider.notifier)
        .retrieveFavoriteGames(
          ref.read(currentUserProvider.notifier).state!.idPlayer,
        );

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  Future<void> _retrievePending() async {
    if (!mounted) return;

    setState(() => isLoading = true);
    setState(() => notFoundResults = false);
    setState(() => showingFollowed = true);

    ref.read(retrieveResultsProvider.notifier).state = [];
    ref.read(searchPendingResultProvider.notifier).state = [];

    await ref
        .read(retrievePendingGamesControllerProvider.notifier)
        .retrievePendingGames(
      ref.read(currentUserProvider.notifier).state!.idPlayer,
    );

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  Future<void> _searchGame(String query) async {
    if (!mounted) return;

    await ref
        .read(searchFavoriteGameControllerProvider.notifier)
        .searchGame(query);
  }

  @override
  void initState() {
    super.initState();

    _retrieveFavoriteGameSub = ref.listenManual<AsyncValue<GamesResponse?>>(
      retrieveFavoriteGamesControllerProvider,
      _onRetrieveFavoriteChanged,
    );
    _retrievePendingGameSub = ref.listenManual<AsyncValue<GamesResponse?>>(
      retrievePendingGamesControllerProvider,
      _onRetrievePendingChanged,
    );

    _searchGameSub = ref.listenManual<AsyncValue<Game?>>(
      searchFavoriteGameControllerProvider,
      _onSearchGameChanged,
    );


    Future.microtask(() => _retrieveFavorite());
  }

  void _onRetrieveFavoriteChanged(
    AsyncValue<GamesResponse?>? previous,
    AsyncValue<GamesResponse?> next,
  ) {
    if (!mounted) return;
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) async {
          if (!mounted) return;
          if (response == null) return;

          if (response.games.isEmpty) {
            setState(() => notFoundResults = true);
          } else {
            for (int i = 0; i < response.games.length; i++) {
              await _searchGame(response.games[i].name);
            }
          }
          final notifier = ref.read(retrieveResultsProvider.notifier);
          notifier.state = response.games;
        },
        error: (error, __) {
          if (!mounted) return;
          setState(() => notFoundResults = true);
          handleFailure(context: context, error: error);
        },
      );
    }
  }

  void _onRetrievePendingChanged(
      AsyncValue<GamesResponse?>? previous,
      AsyncValue<GamesResponse?> next,
      ) {
    if (!mounted) return;
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) async {
          if (!mounted) return;
          if (response == null) return;

          if (response.games.isEmpty) {
            setState(() => notFoundResults = true);
          } else {
            for (int i = 0; i < response.games.length; i++) {
              await _searchGame(response.games[i].name);
            }
          }
          final notifier = ref.read(retrieveResultsProvider.notifier);
          notifier.state = response.games;
        },
        error: (error, __) {
          if (!mounted) return;
          setState(() => notFoundResults = true);
          handleFailure(context: context, error: error);
        },
      );
    }
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

          final notifier = ref.read(searchFavoriteResultProvider.notifier);
          notifier.state = [...notifier.state, response];
        },
        error: (error, __) {},
      );
    }
  }

  @override
  void dispose() {
    _retrieveFavoriteGameSub.close();
    _searchGameSub.close();
    _retrievePendingGameSub.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final results = ref.watch(mergedFavoriteGamesProvider);

    return Scaffold(
      appBar: AppBar(
        title: AppModuleTitle(title: 'Juegos'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 12.0),

              AppModuleButton(
                icon: Icons.search_outlined,
                label: l10n.searchGameTitle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchGameScreen()),
                  );
                },
                color: Colors.grey,
              ),
              const SizedBox(height: 12.0),

              AppFilterTab(
                options: ['Favoritos', 'Pendientes'],
                onChanged: (index) async {
                  switch (index) {
                    case 0:
                      await _retrieveFavorite();
                      break;
                    case 1:
                      await _retrievePending();
                      break;
                  }
                },
              ),
              const SizedBox(height: 16.0),

              if (notFoundResults)
                Text('Sin resultados')
              else if (results.isEmpty)
                AppSkeletonLoader.listTile()
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return AppGameDetailedCard(
                        name: results[i].name,
                        imageUrl:
                            results[i].backgroundImage ??
                            'https://picsum.photos/800/450',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GameScreen(game: results[i]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
