
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/review_management/models/add_to_pendings_request.dart';
import 'package:gamelog/features/review_management/models/add_to_pendings_response.dart';
import 'package:gamelog/features/review_management/repositories/review_management_repository.dart';

class AddGameToPendingsUseCase {
  final ReviewManagementRepository repository;

  AddGameToPendingsUseCase(this.repository);

  Future<Either<Failure, AddToPendingsResponse>> call (AddToPendingsRequest request) async {
    final result = await repository.addGameToPendings(request);
    return result;
  }
}