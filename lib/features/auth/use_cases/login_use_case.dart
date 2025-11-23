import 'package:dartz/dartz.dart';
import 'package:gamelog/features/auth/models/login_request.dart';
import 'package:gamelog/features/auth/models/login_response.dart';
import '../../../core/messages/error_codes.dart';
import '../repositories/auth_repository.dart';
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