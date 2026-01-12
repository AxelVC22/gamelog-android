import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/reviews/delete_review_response.dart';
import 'package:gamelog/core/data/providers/reviews/reviews_providers.dart';
import 'package:gamelog/features/reviews/use_cases/delete_review_use_case.dart';


final deleteReviewControllerProvider =
NotifierProvider<
    DeleteReviewController,
    AsyncValue<DeleteReviewResponse?>
>(DeleteReviewController.new);

class DeleteReviewController
    extends Notifier<AsyncValue<DeleteReviewResponse?>> {
  late final DeleteReviewUseCase _deleteReviewUseCase;

  @override
  AsyncValue<DeleteReviewResponse?> build() {
    final repo = ref.read(reviewManagementRepositoryProvider);

    _deleteReviewUseCase = DeleteReviewUseCase(repo);

    return const AsyncData(null);
  }

  Future<DeleteReviewResponse?> deleteReview(int idGame, int idReview) async {
    state = const AsyncLoading();

    final result = await _deleteReviewUseCase(idGame, idReview);
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
