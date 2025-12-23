
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/statistics/models/retrieve_statistics_response.dart';
import 'package:gamelog/features/statistics/repositories/statistics_repository.dart';

class RetrieveRevivalRetroStatisticsUseCase {
  final StatistisRepository repository;

  RetrieveRevivalRetroStatisticsUseCase(this.repository);

  Future<Either<Failure, RetrieveStatisticsResponse>> call (String fromDate, String toDate) async {
    final result = await repository.retrieveRevivalRetroStatistics(fromDate, toDate);
    return result;
  }
}