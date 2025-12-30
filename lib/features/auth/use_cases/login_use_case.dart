import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/auth/login_request.dart';
import 'package:gamelog/core/data/models/auth/login_response.dart';
import '../../../core/constants/error_codes.dart';
import '../../../core/data/repositories/auth/auth_repository.dart';
import '../../../core/domain/failures/failure.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, LoginResponse>> call(LoginRequest request) async {

    if (request.password.trim().isEmpty || request.password.length < 3 || request.password.length > 50) {
      return left(Failure(ErrorCodes.invalidPassword));
    }

    if (request.email.isEmpty || !request.email.contains("@") || request.email.length > 50) {
      return left(Failure(ErrorCodes.invalidEmail));
    }

    final result = await repository.login(request);



    return result;
  }
}