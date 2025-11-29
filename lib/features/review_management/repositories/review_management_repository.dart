import 'package:dartz/dartz.dart';

import '../../../core/domain/entities/game.dart';
import '../../../core/domain/failures/failure.dart';

abstract class ReviewManagementRepository {

  Future<Either<Failure, Game>> searchGame (String gameName);

}