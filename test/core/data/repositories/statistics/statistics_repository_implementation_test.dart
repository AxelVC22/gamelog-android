import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:gamelog/core/data/repositories/statistics/statistics_repository_implementation.dart';
import 'package:gamelog/core/data/models/statistics/retrieve_statistics_response.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late StatisticsRepositoryImpl repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repository = StatisticsRepositoryImpl(mockDio);
  });

  group('retrieveTrendStatistics', () {
    const tFromDate = '2023-01-01';
    const tToDate = '2023-12-31';

    test('should return RetrieveStatisticsResponse on 200 success', () async {
      // CORRECCIÓN: Usamos 'juegos' en lugar de 'games' para que el fromJson lo encuentre
      final tResponseData = {'juegos': [], 'error': false};

      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: tResponseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveTrendStatistics(tFromDate, tToDate);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => throw Exception()), isA<RetrieveStatisticsResponse>());
    });

    test('should return empty RetrieveStatisticsResponse on 404', () async {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveTrendStatistics(tFromDate, tToDate);

      expect(result.isRight(), true);
      result.fold(
            (l) => fail('Should be Right'),
            (r) => expect(r.games, isEmpty),
      );
    });

    test('should return Failure on non-200/404 with String message', () async {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: {'mensaje': 'Server Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveTrendStatistics(tFromDate, tToDate);

      expect(result.isLeft(), true);
    });

    test('should return Failure on non-200/404 with List message', () async {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: {'mensaje': ['Error1', 'Error2']},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveTrendStatistics(tFromDate, tToDate);

      expect(result.isLeft(), true);
    });

    test('should return Failure on DioException', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(requestOptions: RequestOptions(path: '')),
      );

      final result = await repository.retrieveTrendStatistics(tFromDate, tToDate);

      expect(result.isLeft(), true);
    });
  });

  group('retrieveRevivalRetroStatistics', () {
    const tFromDate = '2023-01-01';
    const tToDate = '2023-12-31';

    test('should return RetrieveStatisticsResponse on 200 success', () async {
      // CORRECCIÓN: Usamos 'juegos' aquí también
      final tResponseData = {'juegos': [], 'error': false};

      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: tResponseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveRevivalRetroStatistics(tFromDate, tToDate);

      expect(result.isRight(), true);
    });

    test('should return empty RetrieveStatisticsResponse on 404', () async {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveRevivalRetroStatistics(tFromDate, tToDate);

      expect(result.isRight(), true);
      result.fold(
            (l) => fail('Should be Right'),
            (r) => expect(r.games, isEmpty),
      );
    });

    test('should return Failure on server error', () async {
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveRevivalRetroStatistics(tFromDate, tToDate);

      expect(result.isLeft(), true);
    });

    test('should return Failure on DioException', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(requestOptions: RequestOptions(path: '')),
      );

      final result = await repository.retrieveRevivalRetroStatistics(tFromDate, tToDate);

      expect(result.isLeft(), true);
    });
  });
}