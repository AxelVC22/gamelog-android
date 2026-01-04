import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/photos/controllers/profile_photo_controller.dart';
import '../../../../features/photos/use_cases/get_multiple_photos_use_case.dart';
import '../../../../features/photos/use_cases/get_photo_use_case.dart';
import '../../../../features/photos/use_cases/upload_photo_use_case.dart';
import '../../data_sources/photo_grpc_data_source.dart';
import '../../repositories/photos/photo_repository_implementation.dart';
final photoDataSourceProvider = Provider<PhotoGrpcDataSource>((ref) {
  return PhotoGrpcDataSource(
    host: '192.168.0.24',
    port: 1235,
  );
});

// Repository
final photoRepositoryProvider = Provider((ref) {
  final dataSource = ref.watch(photoDataSourceProvider);
  return PhotoRepositoryImpl(dataSource);
});

// Use Cases
final savePhotoUseCaseProvider = Provider((ref) {
  final repository = ref.watch(photoRepositoryProvider);
  return SavePhotoUseCase(repository);
});

final getPhotoUseCaseProvider = Provider((ref) {
  final repository = ref.watch(photoRepositoryProvider);
  return GetPhotoUseCase(repository);
});

final getMultiplePhotosUseCaseProvider = Provider((ref) {
  final repository = ref.watch(photoRepositoryProvider);
  return GetMultiplePhotosUseCase(repository);
});

// Controller
final profilePhotoControllerProvider =
StateNotifierProvider<ProfilePhotoController, PhotoState>((ref) {
  return ProfilePhotoController(
    savePhotoUseCase: ref.watch(savePhotoUseCaseProvider),
    getPhotoUseCase: ref.watch(getPhotoUseCaseProvider),
    getMultiplePhotosUseCase: ref.watch(getMultiplePhotosUseCaseProvider),
  );
});