
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/data/models/statistics/retrieve_statistics_response.dart';
import 'package:gamelog/core/data/providers/statistics/statistics_providers.dart';
import 'package:gamelog/features/statistics/use_cases/retrieve_revival_retro_statistics_use_case.dart';
import 'package:intl/intl.dart';

final retrieveRevivalRetroStatisticsControllerProvider =
NotifierProvider<RetrieveRevivalRetroStatisticsController, AsyncValue<RetrieveStatisticsResponse?>>(
  RetrieveRevivalRetroStatisticsController.new,
);

class RetrieveRevivalRetroStatisticsController extends Notifier<AsyncValue<RetrieveStatisticsResponse?>> {
  late final RetrieveRevivalRetroStatisticsUseCase _retrieveRevivalRetroStatisticsUseCase;

  @override
  AsyncValue<RetrieveStatisticsResponse?> build() {
    final repo = ref.read(statisticsRepositoryProvider);

    _retrieveRevivalRetroStatisticsUseCase = RetrieveRevivalRetroStatisticsUseCase(repo);
    return const AsyncData(null);
  }

  Future<void> retrieveRevivalRetroStatistics(DateTime fromDate, DateTime toDate) async {
    state = const AsyncLoading();

    final result = await _retrieveRevivalRetroStatisticsUseCase(DateFormat('yyyy-MM-dd').format(fromDate), DateFormat('yyyy-MM-dd').format(toDate));

    state = result.fold(
            (f) => AsyncError(f, StackTrace.current),
            (r) => AsyncData(r)
    );
  }
}