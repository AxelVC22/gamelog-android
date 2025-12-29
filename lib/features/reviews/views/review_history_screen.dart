import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_review_history_response.dart';
import 'package:gamelog/features/reviews/controllers/retrieve_review_history_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/entities/review.dart';

import '../../../core/presentation/failure_handler.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_poster_review_card.dart';
import '../../../core/data/providers/auth/auth_providers.dart';
import '../controllers/search_game_controller.dart';

final searchResultProvider = StateProvider.autoDispose<List<Game>>((ref) => []);

final retrieveResultsProvider = StateProvider.autoDispose<List<Review>>(
  (ref) => [],
);

class ReviewHistoryScreen extends ConsumerStatefulWidget {
  final int idPlayerToSearch;
  const ReviewHistoryScreen({super.key, required this.idPlayerToSearch});

  @override
  ConsumerState<ReviewHistoryScreen> createState() =>
      _ReviewHistoryScreenState();
}

class _ReviewHistoryScreenState extends ConsumerState<ReviewHistoryScreen> {
  late final ProviderSubscription _searchGameSub;
  late final ProviderSubscription _reviewHistorySub;
  bool noResults = false;

  Future<void> _searchGame(String query) async {
    await ref.read(searchGameControllerProvider.notifier).searchGame(query);
  }

  @override
  void initState() {
    super.initState();

    _searchGameSub = ref.listenManual<AsyncValue<Game?>>(
      searchGameControllerProvider,
      _onSearchGameChanged,
    );

    _reviewHistorySub = ref
        .listenManual<AsyncValue<RetrieveReviewHistoryResponse?>>(
          retrieveReviewHistoryControllerProvider,
          _onRetrieveHistoryChanged,
        );

    Future.microtask(_search);
  }

  Future<void> _search() async {
    if (!mounted) return;

    ref.read(searchResultProvider.notifier).state = [];
    ref.read(retrieveResultsProvider.notifier).state = [];

    final idPlayer = ref.read(currentUserProvider)!.idPlayer;

    await ref
        .read(retrieveReviewHistoryControllerProvider.notifier)
        .retrieveReviewHistory(widget.idPlayerToSearch, idPlayer);
  }

  @override
  void dispose() {
    _searchGameSub.close();
    _reviewHistorySub.close();
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

  void _onRetrieveHistoryChanged(
    AsyncValue<RetrieveReviewHistoryResponse?>? previous,
    AsyncValue<RetrieveReviewHistoryResponse?> next,
  ) async {
    if (previous?.isLoading == true && !next.isLoading) {
      next.when(
        loading: () {},
        data: (response) async {
          if (response == null) return;
          if (response.reviews.isEmpty) {
            setState(() => noResults = true);
          } else {
            ref.read(retrieveResultsProvider.notifier).state = response.reviews;
          }

          for (final review in response.reviews) {
            await _searchGame(review.name);
          }
        },
        error: (error, __) {
          setState(() => noResults = true);
          handleFailure(context: context, error: error);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(retrieveResultsProvider);

    final images = ref.watch(searchResultProvider);

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.reviewHistoryTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              if (noResults)
                Text('No results')
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, i) {
                      final image = i < images.length
                          ? images[i].backgroundImage
                          : null;

                      return AppPosterReviewCard(
                        date: DateTime.parse(results[i].date),
                        opinion: results[i].opinion,
                        imageUrl: image ?? 'https://picsum.photos/800/450',
                        name: results[i].name,
                        rating: results[i].rating,
                        onTap: () {},
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
