import 'package:gamelog/core/data/repositories/games/game_repository.dart';
import 'package:gamelog/core/data/repositories/games/game_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../network/dio_client.dart';
import '../reviews/reviews_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'games_providers.g.dart';

@riverpod
GameRepository gameRepository(
    Ref ref,
    ) {
  return GameRepositoryImpl(
      ref.watch(dioRawgProvider),
      ref.read(apiKeyProvider),
    ref.watch(dioProvider)
  );
}