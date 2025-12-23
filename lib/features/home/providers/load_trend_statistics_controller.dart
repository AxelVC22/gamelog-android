import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/statistics/models/retrieve_statistics_response.dart';
import 'package:gamelog/features/statistics/providers/statistics_providers.dart';
import 'package:gamelog/features/statistics/use_cases/retrieve_trend_statistics_use_case.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/week_range.dart';

final loadTrendStatisticsControllerProvider =
    NotifierProvider<
      LoadTrendStatisticsController,
      AsyncValue<RetrieveStatisticsResponse?>
    >(LoadTrendStatisticsController.new);

class LoadTrendStatisticsController
    extends Notifier<AsyncValue<RetrieveStatisticsResponse?>> {
  late final RetrieveTrendStatisticsUseCase _retrieveTrendStatisticsUseCase;

  @override
  AsyncValue<RetrieveStatisticsResponse?> build() {
    final repoStatistics = ref.read(statisticsRepositoryProvider);

    _retrieveTrendStatisticsUseCase = RetrieveTrendStatisticsUseCase(
      repoStatistics,
    );
    return const AsyncData(null);
  }

  Future<void> loadTrendStatistics() async {
    state = const AsyncLoading();

    final week = getCurrentWeekRange();

    final result = await _retrieveTrendStatisticsUseCase(
      DateFormat('yyyy-MM-dd').format(week.start),
      DateFormat('yyyy-MM-dd').format(week.end),
    );

    state = result.fold(
      (f) => AsyncError(f, StackTrace.current),
      (r) => AsyncData(r),
    );
  }

  Future<void> loadDetailedGames() async {
    state = const AsyncLoading();
  }
}
