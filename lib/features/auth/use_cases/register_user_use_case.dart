import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/auth/register_user_reponse.dart';
import '../../../core/domain/failures/failure.dart';
import '../../../core/constants/error_codes.dart';
import '../../../core/data/models/auth/register_user_request.dart';
import '../../../core/data/repositories/auth/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, RegisterUserResponse>> call(RegisterUserRequest request) async {

    if (request.name.trim().isEmpty || request.name.length < 3 || request.name.length > 50) {
      return left(Failure(ErrorCodes.invalidName));
    }

    if (request.fathersSurname.trim().isEmpty || request.fathersSurname.length < 3 || request.fathersSurname.length > 50) {
      return left(Failure(ErrorCodes.invalidFathersSurname));
    }

    if (request.mothersSurname != null && (request.mothersSurname!.length < 3 || request.mothersSurname!.length > 50)) {
      return left(Failure(ErrorCodes.invalidMothersSurname));
    }

    if (request.username.trim().isEmpty || request.username.length < 3 || request.username.length > 50) {
      return left(Failure(ErrorCodes.invalidUsername));
    }

    if (request.password.trim().isEmpty || request.password.length < 3 || request.password.length > 50) {
      return left(Failure(ErrorCodes.invalidPassword));
    }

    if (request.email.isEmpty || !request.email.contains("@") || request.email.length > 50) {
      return left(Failure(ErrorCodes.invalidEmail));
    }

    if (request.description.trim().isEmpty || request.description.length < 3 || request.description.length > 70) {
      return left(Failure(ErrorCodes.invalidDescription));
    }

    final result = await repository.registerUser(request);

    return result;
  }
}
