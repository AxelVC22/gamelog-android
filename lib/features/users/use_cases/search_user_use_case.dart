import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/users/search_user_response.dart';
import 'package:gamelog/core/data/repositories/users/users_repository.dart';
import '../../../core/constants/error_codes.dart';
import '../../../core/domain/failures/failure.dart';

class SearchUserUseCase {
  final UsersRepository repository;

  SearchUserUseCase(this.repository);

  Future<Either<Failure, SearchUserResponse>> call(String username) async {

    if (username.trim().isEmpty || username.length > 50) {
      return left(Failure.local(ErrorCodes.invalidUsername));
    }


    final result = await repository.searchUser(username);

    return result;
  }
}