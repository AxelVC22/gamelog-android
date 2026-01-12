// domain/repositories/photo_repository.dart
import 'dart:typed_data';

class PhotoResult {
  final Uint8List imageData;
  final bool isDefault;
  final String message;

  PhotoResult({
    required this.imageData,
    required this.isDefault,
    required this.message,
  });
}

abstract class PhotoRepository {
  Future<bool> savePhoto(String playerId, Uint8List imageData);
  Future<PhotoResult> getPhoto(String playerId);
  Future<Map<String, Uint8List>> getMultiplePhotos(List<String> playerIds);
  }