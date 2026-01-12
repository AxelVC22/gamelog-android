import 'package:flutter/foundation.dart';
import 'package:gamelog/core/data/repositories/photos/profile_picture/photo_repository.dart';

import '../../../data_sources/multimedia/photo_grpc_data_source.dart';
class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoGrpcDataSource _dataSource;

  PhotoRepositoryImpl(this._dataSource);

  @override
  Future<bool> savePhoto(String playerId, Uint8List imageData) async {
    final response = await _dataSource.savePhoto(
      playerId: playerId,
      imageData: imageData,
    );
    return response.success;
  }

  @override
  Future<PhotoResult> getPhoto(String playerId) async {
    final response = await _dataSource.getPhoto(playerId);

    return PhotoResult(
      imageData: Uint8List.fromList(response.datos),
      isDefault: response.esDefault,
      message: response.message,
    );
  }

  @override
  Future<Map<String, Uint8List>> getMultiplePhotos(List<String> playerIds) async {
    final response = await _dataSource.getMultiplePhotos(playerIds);

    final result = <String, Uint8List>{};
    final defaultPhoto = response.fotoDefault;

    for (final photo in response.fotos) {
      if (photo.tieneFoto) {
        result[photo.idJugador] = Uint8List.fromList(photo.datos);
      } else {
        result[photo.idJugador] = Uint8List.fromList(defaultPhoto);
      }
    }

    return result;
  }
}