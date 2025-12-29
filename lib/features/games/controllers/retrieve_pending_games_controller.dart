
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/providers/games/games_providers.dart';
import 'package:gamelog/core/data/models/games/games_response.dart';
import 'package:gamelog/features/games/use_cases/retrieve_favorite_games_use_case.dart';

import '../use_cases/retrieve_pending_games_use_case.dart';


final retrievePendingGamesControllerProvider =
NotifierProvider<RetrievePendingGamesController, AsyncValue<GamesResponse?>>(
  RetrievePendingGamesController.new,
);

class RetrievePendingGamesController extends Notifier<AsyncValue<GamesResponse?>> {
  late final RetrievePendingGamesUseCase _retrievePendingGamesUseCase;

  @override
  AsyncValue<GamesResponse?> build() {
    final repo = ref.read(gameRepositoryProvider);

    _retrievePendingGamesUseCase = RetrievePendingGamesUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> retrievePendingGames(int idPlayer) async {
    state = const AsyncLoading();

    final result = await _retrievePendingGamesUseCase(idPlayer);

    state = result.fold(
            (f) => AsyncError(f, StackTrace.current),
            (r) => AsyncData(r)
    );
  }
}