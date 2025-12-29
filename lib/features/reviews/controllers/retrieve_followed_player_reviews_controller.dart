
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/reviews/retrieve_player_reviews_response.dart';
import 'package:gamelog/core/data/providers/reviews/reviews_providers.dart';
import '../use_cases/retrieve_followed_player_reviews_use_case.dart';

final retrieveFollowedPlayerReviewsControllerProvider =
NotifierProvider<RetrieveFollowedPlayerReviewsController, AsyncValue<RetrievePlayerReviewsResponse?>>(
  RetrieveFollowedPlayerReviewsController.new,
);

class RetrieveFollowedPlayerReviewsController extends Notifier<AsyncValue<RetrievePlayerReviewsResponse?>> {
  late final RetrieveFollowedPlayerReviewsUseCase _retrieveFollowedPlayerReviewsUseCase;

  @override
  AsyncValue<RetrievePlayerReviewsResponse?> build() {
    final repo = ref.read(reviewManagementRepositoryProvider);

    _retrieveFollowedPlayerReviewsUseCase = RetrieveFollowedPlayerReviewsUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> retrieveFollowedPlayerReviews(int idGame, int idPlayer) async {
    state = const AsyncLoading();

    final result = await _retrieveFollowedPlayerReviewsUseCase(idGame, idPlayer);

    state = result.fold(
            (f) => AsyncError(f, StackTrace.current),
            (r) => AsyncData(r)
    );
  }
}