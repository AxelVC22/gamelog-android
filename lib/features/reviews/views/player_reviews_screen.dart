import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/providers/auth/auth_providers.dart';
import 'package:gamelog/core/data/models/reviews/delete_review_response.dart';
import 'package:gamelog/core/data/models/reviews/like_request.dart';
import 'package:gamelog/core/data/models/reviews/like_response.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_player_reviews_response.dart';
import 'package:gamelog/features/reviews/controllers/delete_review_controller.dart';
import 'package:gamelog/features/reviews/controllers/retrieve_player_reviews_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/widgets/app_skeleton_loader.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/entities/review.dart';
import '../../../core/presentation/failure_handler.dart';
import '../../../widgets/app_filter_tab.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_review_card.dart';
import '../controllers/like_review_controller.dart';
import '../controllers/retrieve_followed_player_reviews_controller.dart';
import '../controllers/unlike_review_controller.dart';

final retrieveResultsProvider = StateProvider.autoDispose<List<Review>>(
  (ref) => [],
);

class PlayerReviewsScreen extends ConsumerStatefulWidget {
  final Game game;
  const PlayerReviewsScreen({super.key, required this.game});

  @override
  ConsumerState<PlayerReviewsScreen> createState() =>
      _PlayerReviewsScreenState();
}

class _PlayerReviewsScreenState extends ConsumerState<PlayerReviewsScreen> {
  bool isLoading = false;
  bool notFoundResults = false;
  late final ProviderSubscription _retrieveReviewsSub;
  late final ProviderSubscription _retrieveFollowedReviewsSub;
  bool showingFollowed = false;

  @override
  void initState() {
    super.initState();

    _retrieveReviewsSub = ref
        .listenManual<AsyncValue<RetrievePlayerReviewsResponse?>>(
          retrievePlayerReviewsControllerProvider,
          _onRetrieveReviewsChanged,
        );

    _retrieveFollowedReviewsSub = ref
        .listenManual<AsyncValue<RetrievePlayerReviewsResponse?>>(
          retrieveFollowedPlayerReviewsControllerProvider,
          _onRetrieveFollowedChanged,
        );

    Future.microtask(() => _retrieveReviews());
  }

  void _onRetrieveReviewsChanged(
    AsyncValue<RetrievePlayerReviewsResponse?>? previous,
    AsyncValue<RetrievePlayerReviewsResponse?> next,
  ) {
    if (!mounted) return;
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (response == null) return;

          if (response.reviews.isEmpty) {
            setState(() => notFoundResults = true);
          }

          ref.read(retrieveResultsProvider.notifier).state = response.reviews;
        },
        error: (error, __) {
          if (!mounted) return;
          setState(() => notFoundResults = true);
          handleFailure(context: context, error: error);
        },
      );
    }
  }

  void _onRetrieveFollowedChanged(
    AsyncValue<RetrievePlayerReviewsResponse?>? previous,
    AsyncValue<RetrievePlayerReviewsResponse?> next,
  ) {
    if (!mounted) return;
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) {
          if (response == null) return;

          if (response.reviews.isEmpty) {
            setState(() => notFoundResults = true);
          }

          ref.read(retrieveResultsProvider.notifier).state = response.reviews;
        },
        error: (error, __) {
          if (!mounted) return;
          setState(() => notFoundResults = true);
          handleFailure(context: context, error: error);
        },
      );
    }
  }

  Future<void> _retrieveReviews() async {
    if (!mounted) return;

    setState(() => isLoading = true);
    setState(() => notFoundResults = false);

    ref.read(retrieveResultsProvider.notifier).state = [];

    int idPlayer = ref.read(currentUserProvider.notifier).state!.idPlayer;

    await ref
        .read(retrievePlayerReviewsControllerProvider.notifier)
        .retrievePlayerReviews(widget.game.id, idPlayer);
  }

  Future<void> _retrieveFollowedReviews() async {
    if (!mounted) return;

    setState(() => isLoading = true);
    setState(() => notFoundResults = false);

    ref.read(retrieveResultsProvider.notifier).state = [];

    int idPlayer = ref.read(currentUserProvider.notifier).state!.idPlayer;

    await ref
        .read(retrieveFollowedPlayerReviewsControllerProvider.notifier)
        .retrieveFollowedPlayerReviews(widget.game.id, idPlayer);
  }

  Future<void> performDeleteReview(int idReview) async {
    await ref
        .read(deleteReviewControllerProvider.notifier)
        .deleteReview(widget.game.id, idReview);
  }

  Future<void> performLikeReview(Review review) async {
    if (!mounted) return;

    final request = LikeRequest(
      idReview: review.idReview,
      idGame: review.idGame,
      idPlayerAuthor: review.idPlayer,
      idPlayer: ref.read(currentUserProvider.notifier).state!.idPlayer,
      gameName: review.name,
    );

    if (!mounted) return;

    await ref.read(likeReviewControllerProvider.notifier).likeReview(request);
  }

  Future<void> performUnlikeReview(Review review) async {
    if (!mounted) return;

    final request = LikeRequest(
      idReview: review.idReview,
      idGame: review.idGame,
      idPlayerAuthor: review.idPlayer,
      idPlayer: ref.read(currentUserProvider.notifier).state!.idPlayer,
      gameName: review.name,
    );

    if (!mounted) return;

    await ref
        .read(unlikeReviewControllerProvider.notifier)
        .unlikeReview(request);
  }

  Future<void> reactToReview(Review review) async {
    if (review.isLiked) {
      await performUnlikeReview(review);
    } else {
      await performLikeReview(review);
    }
  }

  @override
  void dispose() {
    _retrieveReviewsSub.close();
    _retrieveFollowedReviewsSub.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final results = ref.watch(retrieveResultsProvider);

    ref.listen<AsyncValue<DeleteReviewResponse?>>(
      deleteReviewControllerProvider,
      (previous, next) {
        if (previous?.isLoading == true && next.isLoading == false) {
          next.when(
            loading: () {},
            data: (response) {
              ref.read(globalLoadingProvider.notifier).state = false;

              if (response == null) return;

              final notifier = ref.read(retrieveResultsProvider.notifier);

              notifier.state = notifier.state
                  .where((item) => item.idReview != response.idReview)
                  .toList();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(response.message)));
              });
            },
            error: (error, stack) {
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

    ref.listen<AsyncValue<LikeResponse?>>(likeReviewControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;

            if (response == null) return;

            final currentReviews = ref
                .read(retrieveResultsProvider.notifier)
                .state;

            ref.read(retrieveResultsProvider.notifier).state = currentReviews
                .map((review) {
                  if (review.idReview == response.idReview) {
                    return review.copyWith(
                      isLiked: true,
                      likesTotal: review.likesTotal + 1,
                    );
                  }
                  return review;
                })
                .toList();
          },
          error: (error, stack) {
            ref.read(globalLoadingProvider.notifier).state = false;
            handleFailure(context: context, error: error);
          },
        );
      }

      if (next.isLoading) {
        ref.read(globalLoadingProvider.notifier).state = true;
      }
    });

    ref.listen<AsyncValue<LikeResponse?>>(unlikeReviewControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;

            if (response == null) return;

            final currentReviews = ref
                .read(retrieveResultsProvider.notifier)
                .state;

            ref.read(retrieveResultsProvider.notifier).state = currentReviews
                .map((review) {
                  if (review.idReview == response.idReview) {
                    return review.copyWith(
                      isLiked: false,
                      likesTotal: review.likesTotal - 1,
                    );
                  }
                  return review;
                })
                .toList();
          },
          error: (error, stack) {
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
        title: AppModuleTitle(title: l10n.reviewsTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24.0),

              AppFilterTab(
                options: [l10n.allReviews, l10n.friends],
                onChanged: (index) async {
                  switch (index) {
                    case 0:
                      await _retrieveReviews();
                      break;
                    case 1:
                      await _retrieveFollowedReviews();
                      break;
                  }
                },
              ),
              const SizedBox(height: 16.0),

              if (notFoundResults)
                Text('Sin resultados')
              else if (results.isEmpty)
                const AppSkeletonLoader.listTile()
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      return AppReviewCard(
                        likes: results[i].likesTotal,
                        userType: ref
                            .read(currentUserProvider.notifier)
                            .state!
                            .accessType!,
                        date: DateTime.parse(results[i].date),
                        username: results[i].username!,
                        imageUrl: "",
                        rating: results[i].rating,
                        opinion: results[i].opinion,
                        onDelete: () {
                          performDeleteReview(results[i].idReview);
                        },
                        isLiked: results[i].isLiked,
                        onTap: () {},
                        onLiked: () {
                          reactToReview(results[i]);
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
