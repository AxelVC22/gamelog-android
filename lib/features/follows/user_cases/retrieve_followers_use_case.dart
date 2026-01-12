
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/follows/retrieve_social_response.dart';
import 'package:gamelog/core/data/repositories/follows/follow_repository.dart';

import '../../../core/constants/error_codes.dart';

class RetrieveFollowersUseCase {
  final FollowRepository repository;

  RetrieveFollowersUseCase(this.repository);

  Future<Either<Failure, RetrieveSocialResponse>> call (int idPlayer) async {

    if (idPlayer <= 0) {
      return left(Failure(ErrorCodes.unexpectedValuesError));
    }

    final result = await repository.retrieveFollowers(idPlayer);
    return result;
  }
}