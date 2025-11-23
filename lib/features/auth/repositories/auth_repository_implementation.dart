import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import 'package:gamelog/core/messages/error_codes.dart';
import 'package:gamelog/features/auth/models/logout_response.dart';
import 'package:gamelog/features/auth/models/recover_password_request.dart';
import 'package:gamelog/features/auth/models/recover_password_response.dart';
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
          await storage.write(key: 'access_token', value: token);
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

  @override
  Future<Either<Failure, RecoverPasswordResponse>> sendEmail(
    RecoverPasswordRequest request,
  ) async {
    try {
      final response = await dio.post(
        ApiConstants.recoverPassword,
        data: request.toJson(),
        options: Options(validateStatus: (status) => status! < 600),
      );

      if (response.statusCode == 200) {
        final res = RecoverPasswordResponse.fromJson(response.data);
        return Right(
          RecoverPasswordResponse(message: res.message, error: false, step: 1, idAccess: res.idAccess),
        );
      } else {
        return Left(Failure.server(response.data['mensaje']));
      }
    } catch (e) {
      return Left(Failure(ErrorCodes.unexpectedError));
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
        options: Options(validateStatus: (status) => status! < 600),
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
      return Left(Failure(ErrorCodes.unexpectedError));
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
        options: Options(validateStatus: (status) => status! < 600),
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
      return Left(Failure(ErrorCodes.unexpectedError));
    }
  }
}
