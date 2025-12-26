
import 'package:dartz/dartz.dart';
import 'package:gamelog/core/domain/failures/failure.dart';
import 'package:gamelog/features/follows/models/retrieve_social_response.dart';
import 'package:gamelog/features/follows/repositories/follow_repository.dart';

class RetrieveFollowedUseCase {
  final FollowRepository repository;

  RetrieveFollowedUseCase(this.repository);

  Future<Either<Failure, RetrieveSocialResponse>> call (int idPlayer) async {
    final result = await repository.retrieveFollowed(idPlayer);
    return result;
  }
}