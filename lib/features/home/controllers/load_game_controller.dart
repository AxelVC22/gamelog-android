
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/providers/games/games_providers.dart';
import 'package:gamelog/features/reviews/use_cases/search_game_use_case.dart';

import '../../../core/domain/entities/game.dart';

final loadGameControllerProvider =
NotifierProvider<LoadGameController, AsyncValue<Game?>>(
  LoadGameController.new,
);

class LoadGameController extends Notifier<AsyncValue<Game?>> {
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
          return null;
        },
            (r) {
          state = AsyncData(r);
          return r;
        }
    );
  }
}