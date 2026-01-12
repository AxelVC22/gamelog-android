import 'dart:typed_data';

import '../../../core/data/repositories/photos/profile_picture/photo_repository.dart';

class GetMultiplePhotosUseCase {
  final PhotoRepository _repository;

  GetMultiplePhotosUseCase(this._repository);

  Future<Map<String, Uint8List>> call(List<String> playerIds) async {

    final uniqueIds = playerIds.toSet().toList();

    if (uniqueIds.length > 100) {
      throw Exception('No se pueden cargar más de 100 fotos a la vez');
    }

    return await _repository.getMultiplePhotos(uniqueIds);
  }
}