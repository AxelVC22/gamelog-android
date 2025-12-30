import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import 'package:gamelog/core/constants/error_codes.dart';
import 'package:gamelog/core/data/models/auth/logout_response.dart';
import 'package:gamelog/core/data/models/auth/recover_password_request.dart';
import 'package:gamelog/core/data/models/auth/recover_password_response.dart';
import '../../../presentation/dio_error_handler.dart';
import '../../models/auth/login_request.dart';
import '../../models/auth/login_response.dart';
import '../../models/auth/register_user_reponse.dart';
import '../../models/auth/register_user_request.dart';
import '../../../domain/failures/failure.dart';
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
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        final refreshToken = response.data['refresh_token'];

        if (accessToken != null && refreshToken != null) {
          await storage.write(key: 'access_token', value: accessToken);
          await storage.write(key: 'refresh_token', value: refreshToken);


          final loginResponse = LoginResponse.fromJson(response.data);
          return Right(loginResponse);
        } else {
          return Left(Failure(ErrorCodes.unexpectedError));
        }
      } else if (response.statusCode == 401) {
        final message = response.data['mensaje'];
        return Left(Failure.server(message));
      } else {
        final message = response.data['mensaje'];
        return Left(Failure.server(message));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, LogoutResponse>> logout(String email) async {
    try {
      final response = await dio.delete('${ApiConstants.logout}/$email');

      if (response.statusCode == 200) {
        await storage.delete(key: 'access_token');
        await storage.delete(key: 'refresh_token');
        final res = LogoutResponse.fromJson(response.data);
        return Right(LogoutResponse(message: res.message, error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
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
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = RegisterUserResponse.fromJson(response.data);
        return Right(RegisterUserResponse(message: res.message, error: false));
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, RecoverPasswordResponse>> sendEmail(
    RecoverPasswordRequest request,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.recoverPassword,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final res = RecoverPasswordResponse.fromJson(response.data);
        return Right(
          RecoverPasswordResponse(
            message: res.message,
            error: false,
            step: 1,
            idAccess: res.idAccess,
          ),
        );
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, RecoverPasswordResponse>> verifyCode(
    RecoverPasswordRequest request,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.recoverPasswordValidation,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final res = RecoverPasswordResponse.fromJson(response.data);
        return Right(
          RecoverPasswordResponse(message: res.message, error: false, step: 2),
        );
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, RecoverPasswordResponse>> changePassword(
    RecoverPasswordRequest request,
  ) async {
    try {
      final response = await dio.put(
        '${ApiConstants.recoverPasswordChangePassword}/${request.idAccess}',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final res = RecoverPasswordResponse.fromJson(response.data);
        return Right(
          RecoverPasswordResponse(message: res.message, error: false, step: 3),
        );
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
