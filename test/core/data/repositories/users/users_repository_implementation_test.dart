import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:gamelog/core/data/repositories/users/users_repository_implementation.dart';
import 'package:gamelog/core/data/models/users/add_to_black_list_request.dart';
import 'package:gamelog/core/data/models/users/edit_profile_request.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late UsersRepositoryImpl repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repository = UsersRepositoryImpl(mockDio);
  });

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('searchUser', () {
    const tUsername = 'testUser';

    test('should return SearchUserResponse when status code is 200', () async {
      final tResponseData = {
        'cuenta': [],
        'error': false,
        'mensaje': 'Ok'
      };

      when(() => mockDio.get(any())).thenAnswer(
            (_) async => Response(
          data: tResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.searchUser(tUsername);

      expect(result.isRight(), true);
    });

    test('should return Failure when status code is not 200', () async {
      when(() => mockDio.get(any())).thenAnswer(
            (_) async => Response(
          data: {'mensaje': 'Error'},
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.searchUser(tUsername);

      expect(result.isLeft(), true);
    });

    test('should return Failure on DioException', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(requestOptions: RequestOptions(path: '')),
      );

      final result = await repository.searchUser(tUsername);

      expect(result.isLeft(), true);
    });
  });

  group('editProfile', () {
    const tRequest = EditProfileRequest(
      idPlayer: 1,
      userType: 'jugador',
      name: 'Test',
      fathersSurname: 'User',
      username: 'testuser',
      description: 'Desc',
    );

    test('should return EditProfileResponse when status code is 200', () async {
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer(
            (_) async => Response(
          data: {
            'mensaje': 'Updated',
            'error': false,
            'idJugador': 1,
            'nombre': 'Test',
            'primerApellido': 'User',
            'nombreDeUsuario': 'testuser',
            'descripcion': 'Desc',
            'tipoDeUsuario': 'jugador'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.editProfile(tRequest);

      expect(result.isRight(), true);
    });

    test('should return Failure when status code is not 200', () async {
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer(
            (_) async => Response(
          data: {'mensaje': 'Error'},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.editProfile(tRequest);

      expect(result.isLeft(), true);
    });

    test('should return Failure on DioException', () async {
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenThrow(
        DioException(requestOptions: RequestOptions(path: '')),
      );

      final result = await repository.editProfile(tRequest);

      expect(result.isLeft(), true);
    });
  });

  group('getIdAccess', () {
    const tEmail = 'test@test.com';
    const tUserType = 'jugador';

    test('should return idAccess int when status code is 200', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer(
            (_) async => Response(
          data: {
            'idAcceso': 123,
            'error': false,
            'mensaje': 'Ok'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.getIdAccess(tEmail, tUserType);

      expect(result.isRight(), true);
      result.fold((l) => null, (r) => expect(r, 123));
    });

    test('should return Failure when status code is not 200', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer(
            (_) async => Response(
          data: {'mensaje': 'Not found'},
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.getIdAccess(tEmail, tUserType);

      expect(result.isLeft(), true);
    });
  });

  group('changePasswordOrEmail', () {
    const tRequest = EditProfileRequest(
      idPlayer: 1,
      userType: 'jugador',
      oldEmail: 'old@test.com',
      name: 'Test',
      fathersSurname: 'User',
      username: 'testuser',
      description: 'Desc',
    );

    test('should return EditProfileResponse when both calls succeed', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer(
            (_) async => Response(
          data: {
            'idAcceso': 100,
            'error': false,
            'mensaje': 'Ok'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer(
            (_) async => Response(
          data: {
            'mensaje': 'Password changed',
            'error': false,
            'idJugador': 1,
            'nombre': 'Test',
            'primerApellido': 'User',
            'nombreDeUsuario': 'testuser',
            'descripcion': 'Desc',
            'tipoDeUsuario': 'jugador'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.changePasswordOrEmail(tRequest);

      expect(result.isRight(), true);
    });

    test('should return Failure when getIdAccess fails', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer(
            (_) async => Response(
          data: {'mensaje': 'User not found'},
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.changePasswordOrEmail(tRequest);

      expect(result.isLeft(), true);
      verifyNever(() => mockDio.put(any(), data: any(named: 'data')));
    });

    test('should return Failure when update call fails', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer(
            (_) async => Response(
          data: {
            'idAcceso': 100,
            'error': false,
            'mensaje': 'Ok'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer(
            (_) async => Response(
          data: {'mensaje': 'Update failed'},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.changePasswordOrEmail(tRequest);

      expect(result.isLeft(), true);
    });
  });

  group('addToBlackList', () {
    const tRequest = AddToBlackListRequest(
        email: 'bad@test.com',
        userType: 'jugador'
    );

    test('should return AddToBlackListResponse when success', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer(
            (_) async => Response(
          data: {
            'idAcceso': 99,
            'error': false,
            'mensaje': 'Ok'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
            (_) async => Response(
          data: {
            'mensaje': 'User blocked',
            'error': false,
            'idAcceso': 99,
            'estadoAcceso': 'Baneado'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.addToBlackList(tRequest);

      expect(result.isRight(), true);
    });

    test('should return Failure when getIdAccess fails', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.addToBlackList(tRequest);

      expect(result.isLeft(), true);
    });

    test('should parse String error message correctly', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer(
            (_) async => Response(
          data: {
            'idAcceso': 99,
            'error': false,
            'mensaje': 'Ok'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
            (_) async => Response(
          data: {'mensaje': 'Blocked'},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.addToBlackList(tRequest);

      expect(result.isLeft(), true);
    });

    test('should parse List error message correctly', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer(
            (_) async => Response(
          data: {
            'idAcceso': 99,
            'error': false,
            'mensaje': 'Ok'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
            (_) async => Response(
          data: {'mensaje': ['Error 1', 'Error 2']},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.addToBlackList(tRequest);

      expect(result.isLeft(), true);
    });

    test('should handle unknown error message type', () async {
      when(() => mockDio.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer(
            (_) async => Response(
          data: {
            'idAcceso': 99,
            'error': false,
            'mensaje': 'Ok'
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
            (_) async => Response(
          data: {'mensaje': 12345},
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await repository.addToBlackList(tRequest);

      expect(result.isLeft(), true);
    });
  });
}