import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/auth/login_request.dart';
import 'package:gamelog/core/data/models/auth/logout_response.dart';
import 'package:gamelog/core/data/models/auth/recover_password_response.dart';
import '../../../domain/failures/failure.dart';
import '../../models/auth/login_response.dart';
import '../../models/auth/recover_password_request.dart';
import '../../models/auth/register_user_reponse.dart';
import '../../models/auth/register_user_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);

  Future<Either<Failure, RegisterUserResponse>> registerUser(RegisterUserRequest request);

  Future<Either<Failure, LogoutResponse>> logout(String email);

  Future<Either<Failure, RecoverPasswordResponse>> sendEmail(RecoverPasswordRequest request);

  Future<Either<Failure, RecoverPasswordResponse>> verifyCode(RecoverPasswordRequest request);

  Future<Either<Failure, RecoverPasswordResponse>> changePassword(RecoverPasswordRequest request);

}