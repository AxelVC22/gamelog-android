import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gamelog/features/statistics/repositories/statistics_repository_implementation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/providers/auth_providers.dart';
part 'statistics_providers.g.dart';

// final apiKeyProvider = Provider<String>((ref) {
//   return dotenv.env['RAWG_API_KEY']!;
// });


@Riverpod(keepAlive: true)
StatisticsRepositoryImpl statisticsRepository(
    Ref ref,
    ) {
  return StatisticsRepositoryImpl(

      ref.watch(secureStorageProvider),
      ref.watch(dioProvider)
  );
}
