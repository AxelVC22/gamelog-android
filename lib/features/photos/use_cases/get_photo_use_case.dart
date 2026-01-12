import 'dart:typed_data';

import '../../../core/data/repositories/photos/profile_picture/photo_repository.dart';

class GetPhotoUseCase {
  final PhotoRepository _repository;

  GetPhotoUseCase(this._repository);

  Future<PhotoResult> call(String playerId) async {

    return await _repository.getPhoto(playerId);
  }
}