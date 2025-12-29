import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/reviews/like_request.dart';
import 'package:gamelog/core/data/models/reviews/like_response.dart';
import 'package:gamelog/core/data/providers/reviews/reviews_providers.dart';
import 'package:gamelog/features/reviews/use_cases/like_review_use_case.dart';

final likeReviewControllerProvider =
    NotifierProvider<LikeReviewController, AsyncValue<LikeResponse?>>(
      LikeReviewController.new,
    );

class LikeReviewController extends Notifier<AsyncValue<LikeResponse?>> {
  late final LikeReviewUseCase _likeReviewUseCase;

  @override
  AsyncValue<LikeResponse?> build() {
    final repo = ref.read(reviewManagementRepositoryProvider);

    _likeReviewUseCase = LikeReviewUseCase(repo);

    return const AsyncData(null);
  }

  Future<LikeResponse?> likeReview(LikeRequest request) async {
    state = const AsyncLoading();

    final result = await _likeReviewUseCase(request);
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
