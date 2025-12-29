
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/core/data/models/follows/retrieve_social_response.dart';
import 'package:gamelog/core/data/repositories/follows/follow_repository.dart';

class RetrieveFollowersUseCase {
  final FollowRepository repository;

  RetrieveFollowersUseCase(this.repository);

  Future<Either<Failure, RetrieveSocialResponse>> call (int idPlayer) async {
    final result = await repository.retrieveFollowers(idPlayer);
    return result;
  }
}