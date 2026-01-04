// domain/use_cases/upload_photo_use_case.dart
import 'dart:typed_data';

import '../../../core/data/repositories/photos/photo_repository.dart';

class SavePhotoUseCase {
  final PhotoRepository _repository;

  SavePhotoUseCase(this._repository);

  Future<bool> call(String playerId, Uint8List imageData) async {
    if (playerId.isEmpty) {
      throw Exception('El ID del jugador está vacío');
    }

    if (imageData.isEmpty) {
      throw Exception('La imagen está vacía');
    }

    return await _repository.savePhoto(playerId, imageData);
  }
}