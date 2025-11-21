import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_user_reponse.dart';
import '../models/register_user_request.dart';
import '../../../core/domain/failures/failure.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final FlutterSecureStorage storage;

  AuthRepositoryImpl(this.dio, this.storage);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: request.toJson(),
        options: Options(validateStatus: (status) => status! < 600),
      );

      if (response.statusCode == 200) {
        final token = response.headers.value('access_token');

        if (token != null) {
          await storage.write(key: 'token', value: token);
        }
        return Right(LoginResponse.fromJson(response.data));
      } else {
        final message = response.data['mensaje'] ?? 'unexpected_error';
        return Left(Failure(message));
      }
    } catch (e) {
      return Left(Failure('unexpected_error'));
    }
  }

  @override
  Future<Either<Failure, void>> logout(String email) async {
    try {
      await dio.delete('/gamelog/login/$email');
      return Right(null);
    } on DioException catch (e) {
      return Left(
        Failure(e.response?.data['mensaje'] ?? 'Error al cerrar sesión'),
      );
    } catch (e) {
      return Left(Failure("unexpected_error"));
    } finally {
      await storage.delete(key: 'token');
    }
  }

  @override
  Future<Either<Failure, String>> registerUser(
    RegisterUserRequest request,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.register,
        data: request.toJson(),
        options: Options(validateStatus: (status) => status! < 600),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = RegisterUserResponse.fromJson(response.data);
        return Right(res.message);
      } else {
        final res = RegisterUserResponse.fromJson(response.data);
        return Left(Failure(res.message));
      }
    } catch (e) {
      return Left(Failure("unexpected_error"));
    }
  }
}
