import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/games/add_to_favorites_request.dart';
import 'package:gamelog/core/data/models/games/add_to_favorites_response.dart';
import 'package:gamelog/core/data/providers/games/games_providers.dart';
import 'package:gamelog/features/reviews/use_cases/add_game_to_favorites_use_case.dart';


final addGameToFavoritesControllerProvider =
NotifierProvider<
    AddGameToFavoritesController,
    AsyncValue<AddToFavoritesResponse?>
>(AddGameToFavoritesController.new);

class AddGameToFavoritesController
    extends Notifier<AsyncValue<AddToFavoritesResponse?>> {
  late final AddGameToFavoritesUseCase _addGameToFavoritesUseCase;

  @override
  AsyncValue<AddToFavoritesResponse?> build() {
    final repo = ref.read(gameRepositoryProvider);

    _addGameToFavoritesUseCase = AddGameToFavoritesUseCase(repo);

    return const AsyncData(null);
  }

  Future<AddToFavoritesResponse?> addGameToFavorites(AddToFavoritesRequest request) async {
    state = const AsyncLoading();

    final result = await _addGameToFavoritesUseCase(request);
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
