import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/reviews/like_request.dart';
import 'package:gamelog/core/data/models/reviews/like_response.dart';
import 'package:gamelog/core/data/providers/reviews/reviews_providers.dart';
import 'package:gamelog/features/reviews/use_cases/unlike_review_use_case.dart';

final unlikeReviewControllerProvider =
    NotifierProvider<UnlikeReviewController, AsyncValue<LikeResponse?>>(
      UnlikeReviewController.new,
    );

class UnlikeReviewController extends Notifier<AsyncValue<LikeResponse?>> {
  late final UnlikeReviewUseCase _unlikeReviewUseCase;

  @override
  AsyncValue<LikeResponse?> build() {
    final repo = ref.read(reviewManagementRepositoryProvider);

    _unlikeReviewUseCase = UnlikeReviewUseCase(repo);

    return const AsyncData(null);
  }

  Future<LikeResponse?> unlikeReview(LikeRequest request) async {
    state = const AsyncLoading();

    final result = await _unlikeReviewUseCase(request);
    return result.fold(
      (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
      (r) {
        state = AsyncData(r);
        return r;
      },
    );
  }
}
