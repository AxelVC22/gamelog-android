import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';
import '../failures/failure.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    required String userType,
  }) {
    if (email.isEmpty || password.isEmpty || userType.isEmpty) {
      return Future.value(Left(Failure('Todos los campos son requeridos')));
    }
    
    return repository.login(
      email: email,
      password: password,
      userType: userType,
    );
  }
}