import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/review_management/models/review_game_request.dart';
import 'package:gamelog/features/review_management/models/review_game_response.dart';
import 'package:gamelog/features/review_management/providers/review_management_providers.dart';
import 'package:gamelog/features/review_management/use_cases/review_game_use_case.dart';

final reviewGameControllerProvider =
    NotifierProvider<ReviewGameController, AsyncValue<ReviewGameResponse?>>(
      ReviewGameController.new,
    );

class ReviewGameController extends Notifier<AsyncValue<ReviewGameResponse?>> {
  late final ReviewGameUseCase _reviewGameUseCase;

  @override
  AsyncValue<ReviewGameResponse?> build() {
    final repo = ref.read(reviewManagementRepositoryProvider);

    _reviewGameUseCase = ReviewGameUseCase(repo);

    return const AsyncData(null);
  }

  Future<void> reviewGame(ReviewGameRequest request) async {
    state = const AsyncLoading();

    final result = await _reviewGameUseCase(request);

    state = result.fold(
      (f) => AsyncError(f, StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}
