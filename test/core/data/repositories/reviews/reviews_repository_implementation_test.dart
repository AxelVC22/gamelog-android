import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/repositories/reviews/reviews_repository_implementation.dart';
import 'package:gamelog/core/data/models/reviews/review_game_request.dart';
import 'package:gamelog/core/data/models/reviews/add_to_pendings_request.dart';
import 'package:gamelog/core/data/models/reviews/like_request.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ReviewsRepositoryImpl repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repository = ReviewsRepositoryImpl(mockDio);
  });

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('reviewGame', () {
    const tRequest = ReviewGameRequest(
        idGame: 1,
        name: 'Game',
        released: '2022',
        idPlayer: 1,
        rating: 5.0,
        opinion: 'Good game'
    );

    test('should return Failure when registration fails', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.reviewGame(tRequest);
      expect(result.isLeft(), true);
    });

    test('should return Failure when review step fails', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((inv) async {
        final path = inv.positionalArguments[0] as String;
        if (path.contains('registrarVideojuego')) {
          return Response(
              data: {'mensaje': 'Ok', 'idJuego': 1, 'error': false},
              statusCode: 200,
              requestOptions: RequestOptions(path: path)
          );
        }
        return Response(
            data: {'mensaje': 'Error'},
            statusCode: 400,
            requestOptions: RequestOptions(path: path)
        );
      });

      final result = await repository.reviewGame(tRequest);
      expect(result.isLeft(), true);
    });
  });

  group('retrievePlayerReviews', () {
    test('should return empty list on 404', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrievePlayerReviews(1, 1);
      expect(result.isRight(), true);
      result.fold((_) => null, (r) => expect(r.reviews, isEmpty));
    });

    test('should return Failure on server error', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrievePlayerReviews(1, 1);
      expect(result.isLeft(), true);
    });

    test('should return Failure on exception', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.retrievePlayerReviews(1, 1);
      expect(result.isLeft(), true);
    });
  });

  group('addGameToPendings', () {
    const tRequest = AddToPendingsRequest(idGame: 1, idPlayer: 1, name: 'Game', releaseDate: '2022');

    test('should return AddToPendingsResponse on success', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((inv) async {
        final path = inv.positionalArguments[0] as String;
        if (path.contains('registrarVideojuego')) {
          return Response(
              data: {'mensaje': 'Ok', 'idJuego': 1, 'error': false},
              statusCode: 200,
              requestOptions: RequestOptions(path: path)
          );
        }
        return Response(
          data: {
            'mensaje': 'Ok',
            'error': false,
            'idJuego': 1,
            'idJugador': 1
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
      });

      final result = await repository.addGameToPendings(tRequest);
      expect(result.isRight(), true);
    });

    test('should return Failure when add step fails', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((inv) async {
        final path = inv.positionalArguments[0] as String;
        if (path.contains('registrarVideojuego')) {
          return Response(
              data: {'mensaje': 'Ok', 'idJuego': 1, 'error': false},
              statusCode: 200,
              requestOptions: RequestOptions(path: path)
          );
        }
        return Response(
            data: {'mensaje': 'Error'},
            statusCode: 500,
            requestOptions: RequestOptions(path: path)
        );
      });

      final result = await repository.addGameToPendings(tRequest);
      expect(result.isLeft(), true);
    });
  });

  group('retrieveReviewHistory', () {
    test('should return empty list on 404', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveReviewHistory(1, 1);
      expect(result.isRight(), true);
    });

    test('should return Failure on server error', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveReviewHistory(1, 1);
      expect(result.isLeft(), true);
    });
  });

  group('deleteReview', () {
    test('should return DeleteReviewResponse on 200', () async {
      when(() => mockDio.delete(any()))
          .thenAnswer((_) async => Response(
        data: {
          'mensaje': 'Deleted',
          'error': false,
          'idReview': 100,
          'idJuego': 1
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.deleteReview(1, 100);
      expect(result.isRight(), true);
    });

    test('should handle list error messages', () async {
      when(() => mockDio.delete(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': ['Error 1', 'Error 2']},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.deleteReview(1, 100);
      expect(result.isLeft(), true);
    });

    test('should return Failure on exception', () async {
      when(() => mockDio.delete(any())).thenThrow(DioException(requestOptions: RequestOptions(path: '')));
      final result = await repository.deleteReview(1, 100);
      expect(result.isLeft(), true);
    });
  });

  group('likeReview', () {
    const tLikeRequest = LikeRequest(
        idReview: 100,
        idPlayer: 1,
        idGame: 1,
        idPlayerAuthor: 2,
        gameName: 'Game 1'
    );

    test('should return LikeResponse on 200', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {
          'mensaje': 'Liked',
          'error': false,
          'idResena': 100,
          'idJuego': 1,
          'idJugador': 1,
          'idJugadorAutor': 2,
          'nombreJuego': 'Game 1'
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.likeReview(tLikeRequest);
      expect(result.isRight(), true);
    });

    test('should handle String error message', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Already liked'},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.likeReview(tLikeRequest);
      expect(result.isLeft(), true);
    });

    test('should handle List error message', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': ['Error A', 'Error B']},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.likeReview(tLikeRequest);
      expect(result.isLeft(), true);
    });

    test('should return Failure on exception', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.likeReview(tLikeRequest);
      expect(result.isLeft(), true);
    });
  });

  group('unlikeReview', () {
    const tLikeRequest = LikeRequest(
        idReview: 100,
        idPlayer: 1,
        idGame: 1,
        idPlayerAuthor: 2,
        gameName: 'Game 1'
    );

    test('should return LikeResponse on 200', () async {
      when(() => mockDio.delete(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {
          'mensaje': 'Unliked',
          'error': false,
          'idResena': 100,
          'idJuego': 1,
          'idJugador': 1,
          'idJugadorAutor': 2,
          'nombreJuego': 'Game 1'
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.unlikeReview(tLikeRequest);
      expect(result.isRight(), true);
    });

    test('should handle String error message', () async {
      when(() => mockDio.delete(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.unlikeReview(tLikeRequest);
      expect(result.isLeft(), true);
    });

    test('should handle List error message', () async {
      when(() => mockDio.delete(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': ['Err1']},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.unlikeReview(tLikeRequest);
      expect(result.isLeft(), true);
    });

    test('should return Failure on exception', () async {
      when(() => mockDio.delete(any(), data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.unlikeReview(tLikeRequest);
      expect(result.isLeft(), true);
    });
  });

  group('retrieveFollowedPlayerReviews', () {
    test('should return empty list on 404', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFollowedPlayerReviews(1, 1);
      expect(result.isRight(), true);
    });

    test('should return Failure on server error', () async {
      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.retrieveFollowedPlayerReviews(1, 1);
      expect(result.isLeft(), true);
    });
  });
}