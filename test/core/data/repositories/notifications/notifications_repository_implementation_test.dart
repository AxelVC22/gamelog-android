import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gamelog/core/data/repositories/notifications/notifications_repository_implementation.dart';
import 'package:gamelog/core/data/models/notifications/retrieve_notifications_response.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late NotificationsRepositoryImpl repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repository = NotificationsRepositoryImpl(mockDio);
  });

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('retrieveNotifications', () {
    const int tIdPlayer = 1;

    test('should return RetrieveNotificationsResponse when status is 200', () async {
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(
        data: {'notificaciones': [], 'error': false},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveNotifications(tIdPlayer);

      expect(result.isRight(), true);
    });

    test('should return empty RetrieveNotificationsResponse when status is 404', () async {
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'No notifications found'},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveNotifications(tIdPlayer);

      expect(result.isRight(), true);
      result.fold(
            (l) => fail('Should be right'),
            (r) {
          expect(r.notifications, isEmpty);
          expect(r.error, false);
        },
      );
    });

    test('should return Failure when status is not 200 and not 404', () async {
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Server Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveNotifications(tIdPlayer);

      expect(result.isLeft(), true);
    });

    test('should return Failure on DioException', () async {
      when(() => mockDio.get(any())).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.retrieveNotifications(tIdPlayer);

      expect(result.isLeft(), true);
    });
  });
}