import 'package:dartz/dartz.dart';
import 'package:gamelog/core/messages/error_codes.dart';
import 'package:gamelog/features/auth/models/recover_password_request.dart';
import 'package:gamelog/features/auth/models/recover_password_response.dart';
import 'package:gamelog/features/auth/repositories/auth_repository.dart';

import '../../../core/domain/failures/failure.dart';

class RecoverPasswordSendEmailUseCase {
  final AuthRepository repository;

  RecoverPasswordSendEmailUseCase(this.repository);

  Future<Either<Failure, RecoverPasswordResponse>> call(
    RecoverPasswordRequest request,
  ) async {
    if (request.email.trim().isEmpty || !request.email.contains("@") || request.email.length > 50) {
      return left(Failure(ErrorCodes.invalidEmail));
    }
    final result = await repository.sendEmail(request);

    return result;
  }
}

class RecoverPasswordVerifyCodeUseCase {
  final AuthRepository repository;

  RecoverPasswordVerifyCodeUseCase(this.repository);

  Future<Either<Failure, RecoverPasswordResponse>> call(
      RecoverPasswordRequest request,
      ) async {
    if (request.email.trim().isEmpty || !request.email.contains("@") || request.email.length > 50) {
      return left(Failure(ErrorCodes.invalidEmail));
    }
    final result = await repository.verifyCode(request);

    return result;
  }
}

class RecoverPasswordChangePasswordUseCase {
  final AuthRepository repository;

  RecoverPasswordChangePasswordUseCase(this.repository);

  Future<Either<Failure, RecoverPasswordResponse>> call(
      RecoverPasswordRequest request,
      ) async {
    if (request.email.trim().isEmpty || !request.email.contains("@") || request.email.length > 50) {
      return left(Failure(ErrorCodes.invalidEmail));
    }
    final result = await repository.changePassword(request);

    return result;
  }
}

