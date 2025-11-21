// core/domain/use_cases/register_user_use_case.dart
import 'package:dartz/dartz.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/domain/failures/failure.dart';
import '../models/register_user_request.dart';
import '../repositories/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, String>> call(RegisterUserRequest request) {
    return repository.registerUser(request);
  }
}
