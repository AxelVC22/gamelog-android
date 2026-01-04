// domain/repositories/review_multimedia_repository.dart

import 'dart:io';
import 'dart:typed_data';

class MultimediaMetadata {
  final int numFotos;
  final int numVideos;

  MultimediaMetadata({required this.numFotos, required this.numVideos});
}

abstract class ReviewMultimediaRepository {
  Future<void> uploadPhoto(String idReview, int indice, File foto);
  Future<void> uploadVideo(String idReview, File video, {Function(double)? onProgress});
  Future<List<Uint8List>> retrievePhotos(String idReview);
  Future<Uint8List?> retrieveVideo(String idReview, {Function(double)? onProgress});
  Future<MultimediaMetadata> retrieveMetadata(String idReview);
  Future<void> deleteFiles(String idReview);
}