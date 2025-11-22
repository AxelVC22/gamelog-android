import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import 'package:gamelog/core/messages/error_codes.dart';
import 'package:gamelog/features/auth/models/logout_response.dart';
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
        final res = LoginResponse.fromJson(response.data);
        return Right(LoginResponse(error: false, accounts: res.accounts));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, LogoutResponse>> logout(String email) async {
    try {
      final response = await dio.delete(
        '${ApiConstants.logout}/$email',
        options: Options(validateStatus: (status) => status! < 600),
      );

      if (response.statusCode == 200) {
        await storage.delete(key: 'token');
        final res = LogoutResponse.fromJson(response.data);
        return Right(LogoutResponse(message: res.message, error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, RegisterUserResponse>> registerUser(
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
        return Right(RegisterUserResponse(message: res.message, error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }
}
