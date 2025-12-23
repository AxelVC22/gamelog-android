
import 'package:dartz/dartz.dart';

import '../../domain/entities/game.dart';
import '../../domain/failures/failure.dart';

abstract class GameRepository {
  Future<Either<Failure, Game>> searchGame (String gameName);

}