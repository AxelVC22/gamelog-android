import 'package:gamelog/core/data/repositories/games/game_repository.dart';
import 'package:gamelog/core/data/repositories/games/game_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';
import '../reviews/reviews_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'games_providers.g.dart';

@Riverpod(keepAlive: true)
GameRepository gameRepository(
    Ref ref,
    ) {
  return GameRepositoryImpl(
      ref.watch(dioRawgProvider),
      ref.read(apiKeyProvider),
      ref.watch(secureStorageProvider),
    ref.watch(dioProvider)
  );
}