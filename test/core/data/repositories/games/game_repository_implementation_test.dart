import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gamelog/core/data/repositories/games/game_repository_implementation.dart';
import 'package:gamelog/core/data/models/games/add_to_favorites_request.dart';
import 'package:gamelog/core/domain/entities/game.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late GameRepositoryImpl repository;
  late MockDio mockDioRawg;
  late MockDio mockDioBackend;
  const String tApiKey = 'test_key';

  setUp(() {
    mockDioRawg = MockDio();
    mockDioBackend = MockDio();
    repository = GameRepositoryImpl(mockDioRawg, tApiKey, mockDioBackend);
  });

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('searchGame', () {
    const tGameName = 'zelda';

    test('should return Game when status is 200 and no redirect', () async {
      final tGameJson = {
        'id': 1,
        'name': 'Zelda',
        'rating': 4.5,
        'rating_top': 5,
        'redirect': false
      };

      when(() => mockDioRawg.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: tGameJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.searchGame(tGameName);

      expect(result.isRight(), true);
    });

    test('should follow redirect recursively', () async {
      int callCount = 0;
      when(() => mockDioRawg.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async {
        if (callCount == 0) {
          callCount++;
          return Response(
              data: {'redirect': true, 'slug': 'zelda-2'},
              statusCode: 200,
              requestOptions: RequestOptions(path: ''));
        } else {
          return Response(
              data: {'id': 2, 'name': 'Zelda 2', 'rating': 5, 'rating_top': 5},
              statusCode: 200,
              requestOptions: RequestOptions(path: ''));
        }
      });

      final result = await repository.searchGame(tGameName);
      expect(result.isRight(), true);
    });

    test('should return empty Game on 404', () async {
      when(() => mockDioRawg.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.searchGame(tGameName);
      expect(result.isRight(), true);
    });

    test('should return Failure on server error with "error" field', () async {
      when(() => mockDioRawg.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {'error': 'Server Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.searchGame(tGameName);
      expect(result.isLeft(), true);
    });

    test('should return Failure on server error with "detail" field', () async {
      when(() => mockDioRawg.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {'detail': 'Detailed Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.searchGame(tGameName);
      expect(result.isLeft(), true);
    });

    test('should return Failure on DioException', () async {
      when(() => mockDioRawg.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.searchGame(tGameName);
      expect(result.isLeft(), true);
    });
  });

  group('addGameToFavorites', () {
    const tRequest = AddToFavoritesRequest(idGame: 1, idPlayer: 1, name: 'Game', releaseDate: '2022');

    test('should return AddToFavoritesResponse on success (Register + Add)', () async {
      when(() => mockDioBackend.post(any(), data: any(named: 'data')))
          .thenAnswer((inv) async {
        final path = inv.positionalArguments[0] as String;
        if (path.contains('registrarVideojuego')) {
          return Response(
              data: {'mensaje': 'Ok', 'error': false},
              statusCode: 200,
              requestOptions: RequestOptions(path: ''));
        }
        return Response(
            data: {'mensaje': 'Ok', 'error': false},
            statusCode: 200,
            requestOptions: RequestOptions(path: ''));
      });

      final result = await repository.addGameToFavorites(tRequest);
      expect(result.isRight(), true);
    });

    test('should return Failure when _registerGame throws DioException', () async {
      when(() => mockDioBackend.post(any(), data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.addGameToFavorites(tRequest);
      expect(result.isLeft(), true);
    });

    test('should return Failure when addGameToFavorites returns non-200', () async {
      when(() => mockDioBackend.post(any(), data: any(named: 'data')))
          .thenAnswer((inv) async {
        final path = inv.positionalArguments[0] as String;
        if (path.contains('registrarVideojuego')) {
          return Response(
              data: {'mensaje': 'Ok', 'error': false},
              statusCode: 200,
              requestOptions: RequestOptions(path: ''));
        }
        return Response(
            data: {'mensaje': 'Error', 'error': true},
            statusCode: 400,
            requestOptions: RequestOptions(path: ''));
      });

      final result = await repository.addGameToFavorites(tRequest);
      expect(result.isLeft(), true);
    });

    test('should return Failure when addGameToFavorites throws DioException', () async {
      when(() => mockDioBackend.post(any(), data: any(named: 'data')))
          .thenAnswer((inv) async {
        final path = inv.positionalArguments[0] as String;
        if (path.contains('registrarVideojuego')) {
          return Response(
              data: {'mensaje': 'Ok', 'error': false},
              statusCode: 200,
              requestOptions: RequestOptions(path: ''));
        }
        throw DioException(requestOptions: RequestOptions(path: ''));
      });

      final result = await repository.addGameToFavorites(tRequest);
      expect(result.isLeft(), true);
    });
  });

  group('retrieveFavorites', () {
    const int tIdPlayer = 1;

    test('should return GamesResponse when status is 200', () async {
      when(() => mockDioBackend.get(any()))
          .thenAnswer((_) async => Response(
        data: {'juegos': [], 'error': false},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFavorites(tIdPlayer);
      expect(result.isRight(), true);
    });

    test('should return empty GamesResponse when status is 404', () async {
      when(() => mockDioBackend.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Not found'},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFavorites(tIdPlayer);
      expect(result.isRight(), true);
    });

    test('should return Failure when status is 500 (String message)', () async {
      when(() => mockDioBackend.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error String'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFavorites(tIdPlayer);
      expect(result.isLeft(), true);
    });

    test('should return Failure when status is 500 (List message parsing)', () async {
      when(() => mockDioBackend.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': ['Error 1', 'Error 2']},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFavorites(tIdPlayer);
      expect(result.isLeft(), true);
    });

    test('should return Failure on DioException', () async {
      when(() => mockDioBackend.get(any())).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.retrieveFavorites(tIdPlayer);
      expect(result.isLeft(), true);
    });
  });

  group('retrievePendings', () {
    const int tIdPlayer = 1;

    test('should return GamesResponse when status is 200', () async {
      when(() => mockDioBackend.get(any()))
          .thenAnswer((_) async => Response(
        data: {'juegos': [], 'error': false},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrievePendings(tIdPlayer);
      expect(result.isRight(), true);
    });

    test('should return empty GamesResponse when status is 404', () async {
      when(() => mockDioBackend.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Not found'},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrievePendings(tIdPlayer);
      expect(result.isRight(), true);
    });

    test('should return Failure when status is 500 (String message)', () async {
      when(() => mockDioBackend.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error String'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrievePendings(tIdPlayer);
      expect(result.isLeft(), true);
    });

    test('should return Failure when status is 500 (List message parsing)', () async {
      when(() => mockDioBackend.get(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': ['Error 1', 'Error 2']},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrievePendings(tIdPlayer);
      expect(result.isLeft(), true);
    });

    test('should return Failure on DioException', () async {
      when(() => mockDioBackend.get(any())).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.retrievePendings(tIdPlayer);
      expect(result.isLeft(), true);
    });
  });
}