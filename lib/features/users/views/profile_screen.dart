import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/follows/follow_user_request.dart';
import 'package:gamelog/features/follows/controllers/follow_user_controller.dart';
import 'package:gamelog/core/data/models/users/add_to_black_list_request.dart';
import 'package:gamelog/core/data/models/users/add_to_black_list_response.dart';
import 'package:gamelog/core/data/models/users/search_user_response.dart';
import 'package:gamelog/features/users/controllers/add_to_black_list_controller.dart';
import 'package:gamelog/features/users/controllers/search_user_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../core/domain/entities/account.dart';
import '../../../core/domain/entities/game.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/presentation/failure_handler.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_game_detailed_card.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_skeleton_loader.dart';
import '../../../core/data/providers/auth/auth_providers.dart';
import '../../../core/data/models/follows/follow_user_response.dart';
import '../../../core/data/models/games/games_response.dart';
import '../../games/controllers/retrieve_favorite_games_controller.dart';
import '../../reviews/views/game_screen.dart';
import '../../statistics/controllers/search_game_controller.dart';

final searchFavoriteResultProvider = StateProvider.autoDispose<List<Game?>>(
  (ref) => [],
);

final retrieveResultsProvider = StateProvider.autoDispose<List<Game>>(
  (ref) => [],
);
final searchResultProvider = StateProvider.autoDispose<Account?>((ref) => null);

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
      released: detailed.released,
    );
  }).toList();
});

class ProfileScreen extends ConsumerStatefulWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final ProviderSubscription _searchUserSub;
  late final bool isCurrentUser =
      ref.read(currentUserProvider.notifier).state?.username == widget.username;
  late final bool isAdmin =
      ref.read(currentUserProvider.notifier).state?.accessType ==
      UserType.Administrador.name;
  bool notFoundUser = false;
  late final ProviderSubscription _searchGameSub;
  late final ProviderSubscription _retrieveFavoriteGameSub;
  bool isLoading = false;
  bool notFoundResults = false;

  Future<void> _retrieveFavorite() async {
    if (!mounted) return;

    setState(() => isLoading = true);
    setState(() => notFoundResults = false);

    ref.read(retrieveResultsProvider.notifier).state = [];
    ref.read(searchFavoriteResultProvider.notifier).state = [];

    await ref
        .read(retrieveFavoriteGamesControllerProvider.notifier)
        .retrieveFavoriteGames(ref
        .read(searchResultProvider.notifier)
        .state!
        .idPlayer);

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  Future<void> performAddToBlackList(String email, String userType) async {
    if (!mounted) return;

    final request = AddToBlackListRequest(email: email, userType: userType);

    if (!mounted) return;
    await ref
        .read(addToBlackListControllerProvider.notifier)
        .addToBlackList(request);
  }

  Future<void> performFollowUser(int idPlayerToFollow) async {
    if (!mounted) return;

    final request = FollowUserRequest(
      idPlayerFollowed: idPlayerToFollow,
      idPlayerFollower: ref.read(currentUserProvider.notifier).state!.idPlayer,
    );

    if (!mounted) return;
    await ref.read(followUserControllerProvider.notifier).followUser(request);
  }

  Future<void> _searchGame(String query) async {
    if (!mounted) return;
    ref.read(retrieveResultsProvider.notifier).state = [];

    await ref
        .read(searchFavoriteGameControllerProvider.notifier)
        .searchGame(query);
  }

  @override
  void initState() {
    super.initState();
    _searchUserSub = ref.listenManual<AsyncValue<SearchUserResponse?>>(
      loadUserControllerProvider,
      _onSearchUserChanged,
    );

    _retrieveFavoriteGameSub = ref.listenManual<AsyncValue<GamesResponse?>>(
      retrieveFavoriteGamesControllerProvider,
      _onRetrieveFavoriteChanged,
    );

    _searchGameSub = ref.listenManual<AsyncValue<Game?>>(
      searchFavoriteGameControllerProvider,
      _onSearchGameChanged,
    );

    Future.microtask(() => _search(widget.username));
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

  Future<void> _search(String username) async {
    if (!mounted) return;
    ref.read(searchResultProvider.notifier).state = null;

    await ref.read(loadUserControllerProvider.notifier).searchUser(username);
  }

  @override
  void dispose() {
    _searchUserSub.close();
    _retrieveFavoriteGameSub.close();
    _searchGameSub.close();
    super.dispose();
  }

  void _onSearchUserChanged(
    AsyncValue<SearchUserResponse?>? previous,
    AsyncValue<SearchUserResponse?> next,
  ) {
    if (!mounted) return;

    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (!mounted) return;

          if (response == null) return;

          if (response.accounts.first.idPlayer <= 0) {
            notFoundUser = true;
          } else {
            final notifier = ref.read(searchResultProvider.notifier);
            notifier.state = response.accounts.first;
            _retrieveFavorite();

          }
        },
        error: (error, __) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final user = ref.watch(searchResultProvider);
    final results = ref.watch(mergedFavoriteGamesProvider);

    ref.listen<AsyncValue<AddToBlackListResponse?>>(
      addToBlackListControllerProvider,
      (previous, next) {
        if (previous?.isLoading == true && next.isLoading == false) {
          next.when(
            loading: () {},
            data: (response) {
              ref.read(globalLoadingProvider.notifier).state = false;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(response!.message)));
                Navigator.pop(context);
              });
            },
            error: (error, stack) {
              if (!mounted) return;
              ref.read(globalLoadingProvider.notifier).state = false;
              handleFailure(context: context, error: error);
            },
          );
        }
        if (next.isLoading) {
          ref.read(globalLoadingProvider.notifier).state = true;
        }
      },
    );

    ref.listen<AsyncValue<FollowUserResponse?>>(followUserControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(response!.message)));
              Navigator.pop(context);
            });
          },
          error: (error, stack) {
            if (!mounted) return;
            ref.read(globalLoadingProvider.notifier).state = false;

            handleFailure(context: context, error: error);
          },
        );
      }
      if (next.isLoading) {
        ref.read(globalLoadingProvider.notifier).state = true;
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.profileTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              if (notFoundUser)
                Text(l10n.notFoundUser)
              else if (user == null)
                const AppSkeletonLoader(
                  height: 220,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                )
              else
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: const AssetImage(
                                'assets/images/isotipo.png',
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppModuleTitle(
                                    title:
                                        '${user.name} ${user.fathersSurname}\n (${user.username})',
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            AppButton(
                                              text: l10n.follow,
                                              type: AppButtonType.primary,
                                              onPressed: () =>
                                                  performFollowUser(
                                                    user.idPlayer,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: AppButton(
                                          text: l10n.blackList,
                                          type: AppButtonType.danger,
                                          onPressed: isAdmin
                                              ? () async =>
                                                    await performAddToBlackList(
                                                      user.email!,
                                                      user.accessType!,
                                                    )
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            ref
                                .read(searchResultProvider.notifier)
                                .state!
                                .description,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              AppModuleTitle(title: l10n.favoriteGames),

              const Divider(),

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

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
