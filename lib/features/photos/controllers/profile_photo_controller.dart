import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/constants/app_messages.dart';
import 'dart:typed_data';

import '../use_cases/get_multiple_photos_use_case.dart';
import '../use_cases/get_photo_use_case.dart';
import '../use_cases/upload_photo_use_case.dart';

class PhotoState {
  final Uint8List? imageData;
  final bool isLoading;
  final String? error;
  final String? successMessage;
  final bool isDefault;
  final Map<String, Uint8List>? multiplePhotos;

  PhotoState({
    this.imageData,
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.isDefault = false,
    this.multiplePhotos,
  });

  PhotoState copyWith({
    Uint8List? imageData,
    bool? isLoading,
    String? error,
    String? successMessage,
    bool? isDefault,
    Map<String, Uint8List>? multiplePhotos,
  }) {
    return PhotoState(
      imageData: imageData ?? this.imageData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      successMessage: successMessage,
      isDefault: isDefault ?? this.isDefault,
      multiplePhotos: multiplePhotos ?? this.multiplePhotos,
    );
  }
}

class ProfilePhotoController extends StateNotifier<PhotoState> {
  final SavePhotoUseCase _savePhotoUseCase;
  final GetPhotoUseCase _getPhotoUseCase;
  final GetMultiplePhotosUseCase _getMultiplePhotosUseCase;

  ProfilePhotoController({
    required SavePhotoUseCase savePhotoUseCase,
    required GetPhotoUseCase getPhotoUseCase,
    required GetMultiplePhotosUseCase getMultiplePhotosUseCase,
  })  : _savePhotoUseCase = savePhotoUseCase,
        _getPhotoUseCase = getPhotoUseCase,
        _getMultiplePhotosUseCase = getMultiplePhotosUseCase,
        super(PhotoState());

  Future<void> savePhoto(String playerId, Uint8List imageData) async {
    state = state.copyWith(isLoading: true, error: null, successMessage: null);

    try {
      final success = await _savePhotoUseCase(playerId, imageData);

      if (success) {
        state = state.copyWith(
          isLoading: false,
          imageData: imageData,
          successMessage: AppMessages.profilePictureSaveSuccess,
          isDefault: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: AppMessages.profilePictureSaveFail,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> getPhoto(String playerId) async {
    state = state.copyWith(isLoading: true, error: null, successMessage: null, imageData: null);

    try {
      final result = await _getPhotoUseCase(playerId);

      state = state.copyWith(
        isLoading: false,
        imageData: result.imageData,
        isDefault: result.isDefault,

      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  Future<void> getMultiplePhotos(List<String> playerIds) async {
    state = state.copyWith(isLoading: true, error: null, successMessage: null);

    try {
      final photos = await _getMultiplePhotosUseCase(playerIds);

      state = state.copyWith(
        isLoading: false,
        multiplePhotos: photos,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearMessages() {
    state = state.copyWith(error: null, successMessage: null);
  }
}