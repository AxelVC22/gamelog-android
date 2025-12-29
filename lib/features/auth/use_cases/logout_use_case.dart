import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/auth/logout_response.dart';
import 'package:gamelog/core/data/repositories/auth/auth_repository.dart';

import '../../../core/constants/error_codes.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, LogoutResponse>> call(String email) async {
    if (email.isEmpty || !email.contains("@") || email.length > 50) {
      return left(Failure(ErrorCodes.invalidEmail));
    }

    final result = await repository.logout(email);

    return result;
  }
}
