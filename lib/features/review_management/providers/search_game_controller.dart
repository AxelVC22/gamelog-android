
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/review_management/use_cases/search_game_use_case.dart';

import '../../../core/data/providers/games_providers.dart';
import '../../../core/domain/entities/game.dart';

final searchGameControllerProvider =
  NotifierProvider<SearchGameController, AsyncValue<Game?>>(
SearchGameController.new,
);

class SearchGameController extends Notifier<AsyncValue<Game?>> {
  late final SearchGameUseCase _searchGameUseCase;

  @override
  AsyncValue<Game?> build() {
    final repo = ref.read(gameRepositoryProvider);

    _searchGameUseCase = SearchGameUseCase(repo);

    return const AsyncData(null);
  }

  Future<Game?> searchGame(String gameName) async {
    state = const AsyncLoading();

    final result = await _searchGameUseCase(gameName);
    return result.fold(
        (f){
          state = AsyncError(f, StackTrace.current);
        },
        (r) {
          state = AsyncData(r);
          return r;
        }
    );
  }
}