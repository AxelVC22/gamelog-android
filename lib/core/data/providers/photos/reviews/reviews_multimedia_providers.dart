
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import '../../../../../features/multimedia/controllers/review_multimedia_controller.dart';
import '../../../../../features/multimedia/use_cases/delete_multimedia_review_use_case.dart';
import '../../../../../features/multimedia/use_cases/retrieve_review_metadata_use_case.dart';
import '../../../../../features/multimedia/use_cases/retrieve_review_photos_use_case.dart';
import '../../../../../features/multimedia/use_cases/retrieve_review_video_use_case.dart';
import '../../../../../features/multimedia/use_cases/upload_review_photo_use_case.dart';
import '../../../../../features/multimedia/use_cases/upload_review_video_use_case.dart';


import '../../../data_sources/review_multimedia_grpc_data_source.dart';
import '../../../repositories/photos/reviews/review_multimedia_repository.dart';
import '../../../repositories/photos/reviews/review_multimedia_repository_implementation.dart';

final reviewMultimediaDataSourceProvider = Provider<ReviewMultimediaGrpcDataSource>((ref) {
  return ReviewMultimediaGrpcDataSource(
    host: ApiConstants.host,
    port: ApiConstants.port,
  );
});

// Repository
final reviewMultimediaRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(reviewMultimediaDataSourceProvider);
  return ReviewMultimediaRepositoryImpl(dataSource);
});

// Use Cases
final subirFotoUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return SubirFotoUseCase(repository);
});

final subirVideoUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return SubirVideoUseCase(repository);
});

final obtenerFotosUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return ObtenerFotosUseCase(repository);
});

final obtenerVideoUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return ObtenerVideoUseCase(repository);
});

final obtenerMetadataUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return ObtenerMetadataUseCase(repository);
});

final eliminarArchivosUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return EliminarArchivosUseCase(repository);
});

final reviewMultimediaControllerProvider =
StateNotifierProvider<ReviewMultimediaController, UploadState>((ref) {
  return ReviewMultimediaController(
    subirFotoUseCase: ref.watch(subirFotoUseCaseProvider),
    subirVideoUseCase: ref.watch(subirVideoUseCaseProvider),

    eliminarArchivosUseCase: ref.watch(eliminarArchivosUseCaseProvider),
  );
});


final reviewMetadataProvider =
FutureProvider.family<MultimediaMetadata, String>((ref, idReview) {
  final useCase = ref.read(obtenerMetadataUseCaseProvider);
  return useCase(idReview);
});


final reviewPhotosProvider =
FutureProvider.family<List<Uint8List>, String>((ref, idReview) {
  final useCase = ref.read(obtenerFotosUseCaseProvider);
  return useCase(idReview);
});

final reviewVideoProvider =
FutureProvider.family<Uint8List?, String>((ref, idReview) {
  final useCase = ref.read(obtenerVideoUseCaseProvider);
  return useCase(
    idReview: idReview,
    onProgress: (_) {},
  );
});
