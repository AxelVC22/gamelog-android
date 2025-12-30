import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gamelog/core/data/repositories/statistics/statistics_repository_implementation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/dio_client.dart';
part 'statistics_providers.g.dart';

@riverpod
StatisticsRepositoryImpl statisticsRepository(Ref ref) {
  return StatisticsRepositoryImpl(ref.watch(dioProvider));
}
