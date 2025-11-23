import 'package:dartz/dartz.dart';
import 'package:gamelog/features/auth/models/login_request.dart';
import 'package:gamelog/features/auth/models/logout_response.dart';
import 'package:gamelog/features/auth/models/recover_password_response.dart';
import '../../../core/domain/failures/failure.dart';
import '../models/login_response.dart';
import '../models/recover_password_request.dart';
import '../models/register_user_reponse.dart';
import '../models/register_user_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);

  Future<Either<Failure, RegisterUserResponse>> registerUser(RegisterUserRequest request);

  Future<Either<Failure, LogoutResponse>> logout(String email);

  Future<Either<Failure, RecoverPasswordResponse>> sendEmail(RecoverPasswordRequest request);

  Future<Either<Failure, RecoverPasswordResponse>> verifyCode(RecoverPasswordRequest request);

  Future<Either<Failure, RecoverPasswordResponse>> changePassword(RecoverPasswordRequest request);

}