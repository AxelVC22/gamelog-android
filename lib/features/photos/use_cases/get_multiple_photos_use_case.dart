// domain/use_cases/get_multiple_photos_use_case.dart
import 'dart:typed_data';

import '../../../core/data/repositories/photos/photo_repository.dart';

class GetMultiplePhotosUseCase {
  final PhotoRepository _repository;

  GetMultiplePhotosUseCase(this._repository);

  Future<Map<String, Uint8List>> call(List<String> playerIds) async {
    if (playerIds.isEmpty) {
      throw Exception('La lista de IDs está vacía');
    }

    final uniqueIds = playerIds.toSet().toList();

    if (uniqueIds.length > 100) {
      throw Exception('No se pueden cargar más de 100 fotos a la vez');
    }

    return await _repository.getMultiplePhotos(uniqueIds);
  }
}