import 'dart:typed_data';

import '../../../core/constants/error_codes.dart';
import '../../../core/data/repositories/photos/profile_picture/photo_repository.dart';

class SavePhotoUseCase {
  final PhotoRepository _repository;

  SavePhotoUseCase(this._repository);

  Future<bool> call(String playerId, Uint8List imageData) async {

    if (imageData.isEmpty) {
      throw Exception(ErrorCodes.invalidPhoto);
    }

    return await _repository.savePhoto(playerId, imageData);
  }
}