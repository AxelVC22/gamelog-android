import 'package:dartz/dartz.dart';
import 'package:gamelog/core/data/models/users/add_to_black_list_request.dart';
import 'package:gamelog/core/data/models/users/add_to_black_list_response.dart';
import 'package:gamelog/core/data/repositories/users/users_repository.dart';
import '../../../core/domain/failures/failure.dart';

class AddToBlackListUseCase {
  final UsersRepository repository;

  AddToBlackListUseCase(this.repository);

  Future<Either<Failure, AddToBlackListResponse>> call(AddToBlackListRequest request) async {

    final result = await repository.addToBlackList(request);

    return result;
  }
}
