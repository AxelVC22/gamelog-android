import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../failures/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
    required String userType,
  });

  Future<Either<Failure, void>> logout(String email);
}