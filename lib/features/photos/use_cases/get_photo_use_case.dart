// domain/use_cases/get_photo_use_case.dart
import 'dart:typed_data';

import '../../../core/data/repositories/photos/photo_repository.dart';

class GetPhotoUseCase {
  final PhotoRepository _repository;

  GetPhotoUseCase(this._repository);

  Future<PhotoResult> call(String playerId) async {
    if (playerId.isEmpty) {
      throw Exception('El ID del jugador está vacío');
    }

    return await _repository.getPhoto(playerId);
  }
}