
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


import '../../../data_sources/multimedia/review_multimedia_grpc_data_source.dart';
import '../../../repositories/photos/reviews/review_multimedia_repository.dart';
import '../../../repositories/photos/reviews/review_multimedia_repository_implementation.dart';

final reviewMultimediaDataSourceProvider = Provider<ReviewMultimediaGrpcDataSource>((ref) {
  return ReviewMultimediaGrpcDataSource(
    host: ApiConstants.host,
    port: ApiConstants.port,
  );
});

final reviewMultimediaRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(reviewMultimediaDataSourceProvider);
  return ReviewMultimediaRepositoryImpl(dataSource);
});

final uploadPhotoUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return UploadPhotoUseCase(repository);
});

final uploadVideoUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return UploadVideoUseCase(repository);
});

final retrievePhotosUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return RetrievePhotosUseCase(repository);
});

final retrieveVideoUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return RetrieveVideoUseCase(repository);
});

final retrieveMetadataUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return RetrieveMetadataUseCase(repository);
});

final deleteFilesUseCaseProvider = Provider((ref) {
  final repository = ref.watch(reviewMultimediaRepositoryProvider);
  return DeleteFilesUseCase(repository);
});

final reviewMultimediaControllerProvider =
StateNotifierProvider<ReviewMultimediaController, UploadState>((ref) {
  return ReviewMultimediaController(
    uploadPhotoUseCase: ref.watch(uploadPhotoUseCaseProvider),
    uploadVideoUseCase: ref.watch(uploadVideoUseCaseProvider),

    deleteFilesUseCase: ref.watch(deleteFilesUseCaseProvider),
  );
});


final reviewMetadataProvider =
FutureProvider.family<MultimediaMetadata, String>((ref, idReview) {
  final useCase = ref.read(retrieveMetadataUseCaseProvider);
  return useCase(idReview);
});


final reviewPhotosProvider =
FutureProvider.family<List<Uint8List>, String>((ref, idReview) {
  final useCase = ref.read(retrievePhotosUseCaseProvider);
  return useCase(idReview);
});

final reviewVideoProvider =
FutureProvider.family<Uint8List?, String>((ref, idReview) {
  final useCase = ref.read(retrieveVideoUseCaseProvider);
  return useCase(
    idReview: idReview,
    onProgress: (_) {},
  );
});
