
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/statistics/models/retrieve_statistics_response.dart';
import 'package:gamelog/features/statistics/providers/statistics_providers.dart';
import 'package:gamelog/features/statistics/use_cases/retrieve_trend_statistics_use_case.dart';
import 'package:intl/intl.dart';

final retrieveTrendStatisticsControllerProvider =
NotifierProvider<RetrieveTrendStatisticsController, AsyncValue<RetrieveStatisticsResponse?>>(
  RetrieveTrendStatisticsController.new,
);

class RetrieveTrendStatisticsController extends Notifier<AsyncValue<RetrieveStatisticsResponse?>> {
  late final RetrieveTrendStatisticsUseCase _retrieveTrendStatisticsUseCase;

  @override
  AsyncValue<RetrieveStatisticsResponse?> build() {
    final repo = ref.read(statisticsRepositoryProvider);

    _retrieveTrendStatisticsUseCase = RetrieveTrendStatisticsUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> retrieveTrendStatistics(DateTime fromDate, DateTime toDate) async {
    state = const AsyncLoading();

    final result = await _retrieveTrendStatisticsUseCase(DateFormat('yyyy-MM-dd').format(fromDate), DateFormat('yyyy-MM-dd').format(toDate));

    state = result.fold(
            (f) => AsyncError(f, StackTrace.current),
            (r) => AsyncData(r)
    );
  }
}