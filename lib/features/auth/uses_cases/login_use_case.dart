import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/domain/failures/failure.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);


}