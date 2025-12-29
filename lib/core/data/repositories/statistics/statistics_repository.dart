
import 'package:dartz/dartz.dart';

import '../../../domain/failures/failure.dart';
import '../../models/statistics/retrieve_statistics_response.dart';

abstract class StatistisRepository {

  Future<Either<Failure, RetrieveStatisticsResponse>> retrieveTrendStatistics(String fromDate, String toDate);

  Future<Either<Failure, RetrieveStatisticsResponse>> retrieveRevivalRetroStatistics(String fromDate, String toDate);



}