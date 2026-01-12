
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../use_cases/delete_multimedia_review_use_case.dart';
import '../use_cases/upload_review_photo_use_case.dart';
import '../use_cases/upload_review_video_use_case.dart';

class UploadState {
  final bool isLoading;
  final double progress;
  final String? error;

  UploadState({
    this.isLoading = false,
    this.progress = 0.0,
    this.error,
  });

  UploadState copyWith({
    bool? isLoading,
    double? progress,
    String? error,
  }) {
    return UploadState(
      isLoading: isLoading ?? this.isLoading,
      progress: progress ?? this.progress,
      error: error ?? this.error,
    );
  }
}

class ReviewMultimediaController extends StateNotifier<UploadState> {
  final UploadPhotoUseCase uploadPhotoUseCase;
  final UploadVideoUseCase uploadVideoUseCase;
  final DeleteFilesUseCase deleteFilesUseCase;

  ReviewMultimediaController({
    required this.uploadPhotoUseCase,
    required this.uploadVideoUseCase,
    required this.deleteFilesUseCase,
  }) : super(UploadState());

  Future<void> uploadPhoto({
    required String idReview,
    required int index,
    required File photo,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await uploadPhotoUseCase(
        idReview: idReview,
        indice: index,
        foto: photo,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> uploadVideo({
    required String idReview,
    required File video,
  }) async {
    state = state.copyWith(isLoading: true, progress: 0.0, error: null);

    try {
      await uploadVideoUseCase(
        idReview: idReview,
        video: video,
        onProgress: (progress) {
          state = state.copyWith(progress: progress);
        },
      );
      state = state.copyWith(isLoading: false, progress: 0.0);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        progress: 0.0,
        error: e.toString(),
      );
    }
  }

  Future<void> deleteFiles(String idReview) async {
    try {
      await deleteFilesUseCase(idReview);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
