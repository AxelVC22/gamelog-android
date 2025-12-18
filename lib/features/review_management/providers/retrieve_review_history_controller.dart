
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/review_management/models/retrieve_review_history_response.dart';
import 'package:gamelog/features/review_management/providers/review_management_providers.dart';
import 'package:gamelog/features/review_management/use_cases/retrieve_review_history_use_case.dart';

final retrieveReviewHistoryControllerProvider =
NotifierProvider<RetrieveReviewHistoryController, AsyncValue<RetrieveReviewHistoryResponse?>>(
  RetrieveReviewHistoryController.new,
);

class RetrieveReviewHistoryController extends Notifier<AsyncValue<RetrieveReviewHistoryResponse?>> {
  late final RetrieveReviewHistoryUseCase _retrieveReviewHistoryUseCase;

  @override
  AsyncValue<RetrieveReviewHistoryResponse?> build() {
    final repo = ref.read(reviewManagementRepositoryProvider);

    _retrieveReviewHistoryUseCase = RetrieveReviewHistoryUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> retrieveReviewHistory(int idPlayerToSearch, int idPlayer) async {
    state = const AsyncLoading();

    final result = await _retrieveReviewHistoryUseCase(idPlayerToSearch, idPlayer);

    state = result.fold(
            (f) => AsyncError(f, StackTrace.current),
            (r) => AsyncData(r)
    );
  }
}