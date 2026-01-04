
import 'dart:io';
import 'dart:typed_data';

import 'package:gamelog/core/data/repositories/photos/reviews/review_multimedia_repository.dart';

import '../../../data_sources/review_multimedia_grpc_data_source.dart';

class ReviewMultimediaRepositoryImpl implements ReviewMultimediaRepository {
  final ReviewMultimediaGrpcDataSource dataSource;

  ReviewMultimediaRepositoryImpl(this.dataSource);

  @override
  Future<void> uploadPhoto(String idReview, int indice, File foto) async {
    final bytes = await foto.readAsBytes();
    final extension = foto.path.split('.').last;

    final response = await dataSource.uploadPhoto(
      idReview: idReview,
      indice: indice,
      extension: extension,
      data: bytes,
    );

    if (!response.success) {
      throw Exception(response.message);
    }
  }

  @override
  Future<void> uploadVideo(
      String idReview,
      File video, {
        Function(double)? onProgress,
      }) async {
    final bytes = await video.readAsBytes();
    final extension = video.path.split('.').last;

    final response = await dataSource.uploadVideo(
      idReview: idReview,
      extension: extension,
      videoData: bytes,
      onProgress: onProgress,
    );

    if (!response.success) {
      throw Exception(response.message);
    }
  }

  @override
  Future<List<Uint8List>> retrievePhotos(String idReview) async {
    final response = await dataSource.retrievePhotos(idReview);
    return response.fotos.map((foto) => Uint8List.fromList(foto.datos)).toList();
  }

  @override
  Future<Uint8List?> retrieveVideo(
      String idReview, {
        Function(double)? onProgress,
      }) async {
    return await dataSource.retrieveVideo(idReview, onProgress: onProgress);
  }

  @override
  Future<MultimediaMetadata> retrieveMetadata(String idReview) async {
    final response = await dataSource.retrieveMetadata(idReview);
    return MultimediaMetadata(
      numFotos: response.numFotos,
      numVideos: response.numVideos,
    );
  }

  @override
  Future<void> deleteFiles(String idReview) async {
    final response = await dataSource.deleteFiles(idReview);
    if (!response.success) {
      throw Exception(response.message);
    }
  }
}