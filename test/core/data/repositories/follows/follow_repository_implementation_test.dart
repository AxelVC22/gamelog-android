import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gamelog/core/data/repositories/follows/follow_repository_implementation.dart';
import 'package:gamelog/core/data/models/follows/follow_user_request.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late FollowRepositoryImpl repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repository = FollowRepositoryImpl(mockDio);
  });

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('followUser', () {
    const tRequest = FollowUserRequest(idPlayerFollower: 1, idPlayerFollowed: 2);

    test('should return FollowUserResponse when status is 200', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'ok', 'error': false},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.followUser(tRequest);

      expect(result.isRight(), true);
    });

    test('should return Failure when status is not 200', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.followUser(tRequest);

      expect(result.isLeft(), true);
    });

    test('should return Failure on Exception', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.followUser(tRequest);

      expect(result.isLeft(), true);
    });
  });

  group('retrieveFollowed', () {
    const int tPlayerId = 1;

    test('should return RetrieveSocialResponse when status is 200', () async {
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'ok', 'error': false, 'seguidos': []},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFollowed(tPlayerId);

      expect(result.isRight(), true);
    });

    test('should return empty RetrieveSocialResponse when status is 404', () async {
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Not found'},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFollowed(tPlayerId);

      expect(result.isRight(), true);
      result.fold(
            (l) => fail('Should be right'),
            (r) => expect(r.accounts, isEmpty),
      );
    });

    test('should return Failure when status is not 200 and not 404', () async {
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFollowed(tPlayerId);

      expect(result.isLeft(), true);
    });

    test('should return Failure on Exception', () async {
      when(() => mockDio.get(any())).thenThrow(Exception());

      final result = await repository.retrieveFollowed(tPlayerId);

      expect(result.isLeft(), true);
    });
  });

  group('retrieveFollowers', () {
    const int tPlayerId = 1;

    test('should return RetrieveSocialResponse when status is 200', () async {
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'ok', 'error': false, 'seguidores': []},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFollowers(tPlayerId);

      expect(result.isRight(), true);
    });

    test('should return empty RetrieveSocialResponse when status is 404', () async {
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Not found'},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFollowers(tPlayerId);

      expect(result.isRight(), true);
      result.fold(
            (l) => fail('Should be right'),
            (r) => expect(r.accounts, isEmpty),
      );
    });

    test('should return Failure when status is not 200 and not 404', () async {
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFollowers(tPlayerId);

      expect(result.isLeft(), true);
    });

    test('should return Failure on Exception', () async {
      when(() => mockDio.get(any())).thenThrow(Exception());

      final result = await repository.retrieveFollowers(tPlayerId);

      expect(result.isLeft(), true);
    });
  });

  group('unfollowUser', () {
    const int tFollower = 1;
    const int tFollowed = 2;

    test('should return UnfollowUserResponse when status is 200', () async {
      when(() => mockDio.delete(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'ok', 'error': false},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.unfollowUser(tFollower, tFollowed);

      expect(result.isRight(), true);
    });

    test('should return Failure when status is not 200', () async {
      when(() => mockDio.delete(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.unfollowUser(tFollower, tFollowed);

      expect(result.isLeft(), true);
    });

    test('should return Failure on Exception', () async {
      when(() => mockDio.delete(any())).thenThrow(Exception());

      final result = await repository.unfollowUser(tFollower, tFollowed);

      expect(result.isLeft(), true);
    });
  });
}