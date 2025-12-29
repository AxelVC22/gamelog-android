
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_player_reviews_response.dart';
import 'package:gamelog/core/data/providers/reviews/reviews_providers.dart';
import 'package:gamelog/features/reviews/use_cases/retrieve_player_reviews_use_case.dart';

final retrievePlayerReviewsControllerProvider =
    NotifierProvider<RetrievePlayerReviewsController, AsyncValue<RetrievePlayerReviewsResponse?>>(
      RetrievePlayerReviewsController.new,
    );

class RetrievePlayerReviewsController extends Notifier<AsyncValue<RetrievePlayerReviewsResponse?>> {
  late final RetrievePlayerReviewsUseCase _retrievePlayerReviewsUseCase;

  @override
  AsyncValue<RetrievePlayerReviewsResponse?> build() {
    final repo = ref.read(reviewManagementRepositoryProvider);

    _retrievePlayerReviewsUseCase = RetrievePlayerReviewsUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> retrievePlayerReviews(int idGame, int idPlayer) async {
    state = const AsyncLoading();

    final result = await _retrievePlayerReviewsUseCase(idGame, idPlayer);

    state = result.fold(
        (f) => AsyncError(f, StackTrace.current),
        (r) => AsyncData(r)
    );
  }
}