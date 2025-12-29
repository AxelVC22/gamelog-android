
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/providers/games/games_providers.dart';
import 'package:gamelog/core/data/models/games/games_response.dart';
import 'package:gamelog/features/games/use_cases/retrieve_favorite_games_use_case.dart';


final retrieveFavoriteGamesControllerProvider =
NotifierProvider<RetrieveFavoriteGamesController, AsyncValue<GamesResponse?>>(
  RetrieveFavoriteGamesController.new,
);

class RetrieveFavoriteGamesController extends Notifier<AsyncValue<GamesResponse?>> {
  late final RetrieveFavoriteGamesUseCase _retrieveFavoriteGamesUseCase;

  @override
  AsyncValue<GamesResponse?> build() {
    final repo = ref.read(gameRepositoryProvider);

    _retrieveFavoriteGamesUseCase = RetrieveFavoriteGamesUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> retrieveFavoriteGames(int idPlayer) async {
    state = const AsyncLoading();

    final result = await _retrieveFavoriteGamesUseCase(idPlayer);

    state = result.fold(
            (f) => AsyncError(f, StackTrace.current),
            (r) => AsyncData(r)
    );
  }
}