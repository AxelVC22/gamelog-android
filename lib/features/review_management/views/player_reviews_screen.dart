import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/providers/auth_providers.dart';
import 'package:gamelog/features/review_management/models/delete_review_response.dart';
import 'package:gamelog/features/review_management/models/retrieve_player_reviews_response.dart';
import 'package:gamelog/features/review_management/providers/delete_review_controller.dart';
import 'package:gamelog/features/review_management/providers/retrieve_player_reviews_controller.dart';
import 'package:gamelog/features/user_management/views/profile_screen.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/entities/review.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../widgets/app_filter_tab.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_review_card.dart';

final retrieveResultsProvider = StateProvider<List<Review>>((ref) => []);

class PlayerReviewsScreen extends ConsumerStatefulWidget {
  final Game game;
  const PlayerReviewsScreen({super.key, required this.game});

  @override
  ConsumerState<PlayerReviewsScreen> createState() =>
      _PlayerReviewsScreenState();
}

class _PlayerReviewsScreenState extends ConsumerState<PlayerReviewsScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => _search());
  }

  Future<void> _search() async {
    if (!mounted) return;

    setState(() => isLoading = true);

    int idPlayer = ref.read(currentUserProvider.notifier).state!.idPlayer;

    await ref
        .read(retrievePlayerReviewsControllerProvider.notifier)
        .retrievePlayerReviews(widget.game.id, idPlayer);

    if (mounted) setState(() => isLoading = false);
  }

  Future<void> _performDeleteReview(int idReview) async {
    await ref
        .read(deleteReviewControllerProvider.notifier)
        .deleteReview(widget.game.id, idReview);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final results = ref.watch(retrieveResultsProvider);

    ref.listen<AsyncValue<RetrievePlayerReviewsResponse?>>(
      retrievePlayerReviewsControllerProvider,
      (previous, next) {
        if (previous?.isLoading == true && next.isLoading == false) {
          next.when(
            loading: () {},
            data: (response) {
              ref.read(globalLoadingProvider.notifier).state = false;

              if (response == null) return;

              ref.read(retrieveResultsProvider.notifier).state =
                  response.reviews;
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
          ref.read(globalLoadingProvider.notifier).state = true;
        }
      },
    );

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
                ).showSnackBar(SnackBar(content: Text(response!.message)));
              });
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
          ref.read(globalLoadingProvider.notifier).state = true;
        }
      },
    );

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
                onChanged: (index) {},
              ),
              const SizedBox(height: 16.0),

              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
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
                          _performDeleteReview(results[i].idReview);
                        },
                        isLiked: results[i].isLiked,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(_) => ProfileScreen(username: results[i].username!)));
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
