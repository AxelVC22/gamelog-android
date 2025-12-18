import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/review_management/models/retrieve_review_history_response.dart';
import 'package:gamelog/features/review_management/providers/retrieve_review_history_controller.dart';

import 'package:gamelog/l10n/app_localizations.dart';
import 'package:gamelog/l10n/app_localizations_extension.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/entities/review.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../widgets/app_global_loader.dart';
import '../../../widgets/app_icon_button.dart';
import '../../../widgets/app_module_title.dart';
import '../../../widgets/app_poster_review_card.dart';
import '../../auth/providers/auth_providers.dart';
import '../providers/search_game_controller.dart';

final searchResultProvider = StateProvider<List<Game?>>((ref) => []);

final retrieveResultsProvider = StateProvider<List<Review>>((ref) => []);

class ReviewHistoryScreen extends ConsumerStatefulWidget {
  final int idPlayerToSearch;
  const ReviewHistoryScreen({super.key, required this.idPlayerToSearch});

  @override
  ConsumerState<ReviewHistoryScreen> createState() =>
      _ReviewHistoryScreenState();
}

class _ReviewHistoryScreenState extends ConsumerState<ReviewHistoryScreen> {
  bool isLoading = false;

  Future<void> _searchGame(String query) async {
    setState(() => isLoading = true);

    await ref.read(searchGameControllerProvider.notifier).searchGame(query);

    setState(() => isLoading = false);
  }

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
        .read(retrieveReviewHistoryControllerProvider.notifier)
        .retrieveReviewHistory(widget.idPlayerToSearch, idPlayer);

    if (mounted) setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(retrieveResultsProvider);

    final l10n = AppLocalizations.of(context)!;

    ref.listen<AsyncValue<Game?>>(searchGameControllerProvider, (
      previous,
      next,
    ) {
      if (previous?.isLoading == true && next.isLoading == false) {
        next.when(
          loading: () {},
          data: (response) {
            ref.read(globalLoadingProvider.notifier).state = false;

            if (response == null) return;

            ref.read(searchResultProvider.notifier).state.add(response);
          },
          error: (error, stack) {
            ref.read(globalLoadingProvider.notifier).state = false;

            ref.read(searchResultProvider.notifier).state.add(null);

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
    });

    ref.listen<AsyncValue<RetrieveReviewHistoryResponse?>>(
      retrieveReviewHistoryControllerProvider,
      (previous, next) {
        if (previous?.isLoading == true && next.isLoading == false) {
          next.when(
            loading: () {},
            data: (response) async {
              ref.read(globalLoadingProvider.notifier).state = false;

              if (response == null) return;
              for (int i = 0; i < response.reviews.length; i++) {
                await _searchGame(response.reviews[i].name);
              }

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        title: AppModuleTitle(title: l10n.reviewHistoryTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (_, i) {
                    return AppPosterReviewCard(
                      date: DateTime.parse(results[i].date),
                      opinion: results[i].opinion,
                      imageUrl:
                          ref
                              .read(searchResultProvider.notifier)
                              .state[i]
                              ?.backgroundImage ??
                          'https://picsum.photos/800/450',
                      // rating: results[i].rating,
                      // opinion: results[i].opinion,
                      // onDelete: () {},
                      // isLiked: results[i].isLiked,
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => ProfileScreen(),
                        //   ),
                        // );
                      },
                      name: results[i].name,
                      rating: results[i].rating,
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
