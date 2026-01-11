import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/data/repositories/auth/auth_repository_implementation.dart';
import 'package:gamelog/core/data/models/auth/login_request.dart';
import 'package:gamelog/core/data/models/auth/register_user_request.dart';
import 'package:gamelog/core/data/models/auth/recover_password_request.dart';

class MockDio extends Mock implements Dio {}
class MockStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late AuthRepositoryImpl repository;
  late MockDio mockDio;
  late MockStorage mockStorage;

  setUp(() {
    mockDio = MockDio();
    mockStorage = MockStorage();
    repository = AuthRepositoryImpl(mockDio, mockStorage);
  });

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('login', () {
    const tRequest = LoginRequest(email: 'test@test.com', password: '123', userType: 'player');

    test('should return LoginResponse when status is 200 and tokens are present', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'access_token': 'at', 'refresh_token': 'rt', 'error': false, 'cuenta': []},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async => {});

      final result = await repository.login(tRequest);

      expect(result.isRight(), true);
      verify(() => mockStorage.write(key: 'access_token', value: 'at')).called(1);
    });

    test('should return Failure when status is 200 but tokens are missing', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'error': false, 'cuenta': []},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.login(tRequest);
      expect(result.isLeft(), true);
    });

    test('should return Failure when status is 401', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Credenciales incorrectas'},
        statusCode: 401,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.login(tRequest);
      expect(result.isLeft(), true);
    });

    test('should return Failure when status is 500', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error interno'},
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.login(tRequest);
      expect(result.isLeft(), true);
    });

    test('should return Failure on DioException', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await repository.login(tRequest);
      expect(result.isLeft(), true);
    });
  });

  group('logout', () {
    test('should return success when status is 200', () async {
      when(() => mockDio.delete(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Sesión cerrada', 'error': false},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
      when(() => mockStorage.delete(key: any(named: 'key'))).thenAnswer((_) async => {});

      final result = await repository.logout('test@test.com');
      expect(result.isRight(), true);
    });

    test('should return Failure when status is not 200', () async {
      when(() => mockDio.delete(any()))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.logout('test@test.com');
      expect(result.isLeft(), true);
    });

    test('should return Failure on Exception', () async {
      when(() => mockDio.delete(any())).thenThrow(Exception());
      final result = await repository.logout('test@test.com');
      expect(result.isLeft(), true);
    });
  });

  group('registerUser', () {
    const tRequest = RegisterUserRequest(
        email: 'a', password: 'b', status: 'c', name: 'd',
        fathersSurname: 'e', username: 'f', description: 'g', userType: 'h'
    );

    test('should return success when status is 201', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Registrado', 'error': false},
        statusCode: 201,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.registerUser(tRequest);
      expect(result.isRight(), true);
    });

    test('should return Failure when status is 400', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Datos inválidos'},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await repository.registerUser(tRequest);
      expect(result.isLeft(), true);
    });

    test('should return Failure on Exception', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(Exception());
      final result = await repository.registerUser(tRequest);
      expect(result.isLeft(), true);
    });
  });

  group('recoverPassword flows', () {
    const tRequest = RecoverPasswordRequest(email: 'a', userType: 'p', idAccess: 1, password: 'new');

    test('sendEmail success', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'ok', 'error': false, 'idAccess': 1},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
      final result = await repository.sendEmail(tRequest);
      expect(result.isRight(), true);
    });

    test('sendEmail failure', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'No encontrado'},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ));
      final result = await repository.sendEmail(tRequest);
      expect(result.isLeft(), true);
    });

    test('verifyCode success', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'ok', 'error': false},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
      final result = await repository.verifyCode(tRequest);
      expect(result.isRight(), true);
    });

    test('verifyCode failure', () async {
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Código incorrecto'},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));
      final result = await repository.verifyCode(tRequest);
      expect(result.isLeft(), true);
    });

    test('changePassword success', () async {
      when(() => mockDio.put(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'ok', 'error': false},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
      final result = await repository.changePassword(tRequest);
      expect(result.isRight(), true);
    });

    test('changePassword failure', () async {
      when(() => mockDio.put(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
        data: {'mensaje': 'Error'},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ));
      final result = await repository.changePassword(tRequest);
      expect(result.isLeft(), true);
    });

    test('changePassword exception', () async {
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenThrow(Exception());
      final result = await repository.changePassword(tRequest);
      expect(result.isLeft(), true);
    });
  });
}