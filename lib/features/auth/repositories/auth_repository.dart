import 'package:dartz/dartz.dart';
import 'package:gamelog/features/auth/models/login_request.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/domain/failures/failure.dart';
import '../models/login_response.dart';
import '../models/register_user_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);

  Future<Either<Failure, String>> registerUser(RegisterUserRequest request);

  Future<Either<Failure, void>> logout(String email);
}