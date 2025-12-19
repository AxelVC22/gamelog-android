import 'package:dartz/dartz.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_request.dart';
import 'package:gamelog/features/user_management/models/add_to_black_list_response.dart';
import 'package:gamelog/features/user_management/repositories/user_management_repository.dart';
import '../../../core/domain/failures/failure.dart';

class AddToBlackListUseCase {
  final UserManagementRepository repository;

  AddToBlackListUseCase(this.repository);

  Future<Either<Failure, AddToBlackListResponse>> call(AddToBlackListRequest request) async {

    final result = await repository.addToBlackList(request);

    return result;
  }
}
