import 'package:gamelog/core/data/repositories/game_reporitory.dart';
import 'package:gamelog/core/data/repositories/game_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/auth/providers/auth_providers.dart';
import '../../../features/review_management/providers/review_management_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'games_providers.g.dart';

@Riverpod(keepAlive: true)
GameRepository gameRepository(
    GameRepositoryRef ref,
    ) {
  return GameRepositoryImpl(
      ref.watch(dioRawgProvider),
      ref.read(apiKeyProvider),
      ref.watch(secureStorageProvider),
  );
}