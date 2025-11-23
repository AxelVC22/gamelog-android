import 'package:dartz/dartz.dart';
import 'package:gamelog/features/auth/models/login_request.dart';
import 'package:gamelog/features/auth/models/login_response.dart';
import 'package:gamelog/features/user_management/models/search_user_response.dart';
import 'package:gamelog/features/user_management/repositories/user_management_repository.dart';
import '../../../core/messages/error_codes.dart';
import '../../../core/domain/failures/failure.dart';

class SearchUserUseCase {
  final UserManagementRepository repository;

  SearchUserUseCase(this.repository);

  Future<Either<Failure, SearchUserResponse>> call(String username) async {

    if (username.trim().isEmpty || username.length > 50) {
      return left(Failure(ErrorCodes.invalidUsername));
    }


    final result = await repository.searchUser(username);

    return result;
  }
}