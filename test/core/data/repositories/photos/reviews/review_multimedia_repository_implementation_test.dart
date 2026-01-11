import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:gamelog/core/data/repositories/photos/reviews/review_multimedia_repository_implementation.dart';
import 'package:gamelog/core/data/repositories/photos/reviews/review_multimedia_repository.dart';
import 'package:gamelog/core/data/data_sources/review_multimedia_grpc_data_source.dart';

import 'package:gamelog/grpc/Multimedia_De_Resenia.pb.dart';

class MockDataSource extends Mock implements ReviewMultimediaGrpcDataSource {}
class MockFile extends Mock implements File {}

void main() {
  late ReviewMultimediaRepositoryImpl repository;
  late MockDataSource mockDataSource;
  late MockFile mockFile;

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
    registerFallbackValue((double progress) {});
  });

  setUp(() {
    mockDataSource = MockDataSource();
    mockFile = MockFile();
    repository = ReviewMultimediaRepositoryImpl(mockDataSource);
  });

  group('uploadPhoto', () {
    const String tIdReview = '123';
    const int tIndex = 0;
    final Uint8List tBytes = Uint8List.fromList([1, 2, 3]);

    test('should complete successfully when upload is successful', () async {
      when(() => mockFile.readAsBytes()).thenAnswer((_) async => tBytes);
      when(() => mockFile.path).thenReturn('image.jpg');

      final tResponse = SubirFotoResponse()
        ..success = true
        ..message = 'ok';

      when(() => mockDataSource.uploadPhoto(
        idReview: any(named: 'idReview'),
        indice: any(named: 'indice'),
        extension: any(named: 'extension'),
        data: any(named: 'data'),
      )).thenAnswer((_) async => tResponse);

      expect(
            () => repository.uploadPhoto(tIdReview, tIndex, mockFile),
        returnsNormally,
      );
    });

    test('should throw Exception when response success is false', () async {
      when(() => mockFile.readAsBytes()).thenAnswer((_) async => tBytes);
      when(() => mockFile.path).thenReturn('image.jpg');

      final tResponse = SubirFotoResponse()
        ..success = false
        ..message = 'Error uploading';

      when(() => mockDataSource.uploadPhoto(
        idReview: any(named: 'idReview'),
        indice: any(named: 'indice'),
        extension: any(named: 'extension'),
        data: any(named: 'data'),
      )).thenAnswer((_) async => tResponse);

      expect(
            () => repository.uploadPhoto(tIdReview, tIndex, mockFile),
        throwsException,
      );
    });
  });

  group('uploadVideo', () {
    const String tIdReview = '123';
    final Uint8List tBytes = Uint8List.fromList([4, 5, 6]);

    test('should complete successfully when upload is successful', () async {
      when(() => mockFile.readAsBytes()).thenAnswer((_) async => tBytes);
      when(() => mockFile.path).thenReturn('video.mp4');

      final tResponse = SubirVideoResponse()
        ..success = true
        ..message = 'ok';

      when(() => mockDataSource.uploadVideo(
        idReview: any(named: 'idReview'),
        extension: any(named: 'extension'),
        videoData: any(named: 'videoData'),
        onProgress: any(named: 'onProgress'),
      )).thenAnswer((_) async => tResponse);

      expect(
            () => repository.uploadVideo(tIdReview, mockFile),
        returnsNormally,
      );
    });

    test('should throw Exception when response success is false', () async {
      when(() => mockFile.readAsBytes()).thenAnswer((_) async => tBytes);
      when(() => mockFile.path).thenReturn('video.mp4');

      final tResponse = SubirVideoResponse()
        ..success = false
        ..message = 'Error uploading video';

      when(() => mockDataSource.uploadVideo(
        idReview: any(named: 'idReview'),
        extension: any(named: 'extension'),
        videoData: any(named: 'videoData'),
        onProgress: any(named: 'onProgress'),
      )).thenAnswer((_) async => tResponse);

      expect(
            () => repository.uploadVideo(tIdReview, mockFile),
        throwsException,
      );
    });
  });

  group('retrievePhotos', () {
    const String tIdReview = '123';

    test('should return List<Uint8List> when data source returns photos', () async {
      final tFoto = FotoReviewInfo()..datos = [10, 20];
      final tResponse = ObtenerFotosResponse()..fotos.add(tFoto);

      when(() => mockDataSource.retrievePhotos(any()))
          .thenAnswer((_) async => tResponse);

      final result = await repository.retrievePhotos(tIdReview);

      expect(result, isA<List<Uint8List>>());
      expect(result.length, 1);
      expect(result.first, [10, 20]);
    });

    test('should return empty list when data source returns no photos', () async {
      final tResponse = ObtenerFotosResponse();

      when(() => mockDataSource.retrievePhotos(any()))
          .thenAnswer((_) async => tResponse);

      final result = await repository.retrievePhotos(tIdReview);

      expect(result, isEmpty);
    });

    test('should throw Exception when data source throws', () async {
      when(() => mockDataSource.retrievePhotos(any())).thenThrow(Exception());

      expect(
            () => repository.retrievePhotos(tIdReview),
        throwsException,
      );
    });
  });

  group('retrieveVideo', () {
    const String tIdReview = '123';
    final Uint8List tVideoData = Uint8List.fromList([100, 200]);

    test('should return Uint8List when video exists', () async {
      when(() => mockDataSource.retrieveVideo(any(), onProgress: any(named: 'onProgress')))
          .thenAnswer((_) async => tVideoData);

      final result = await repository.retrieveVideo(tIdReview);

      expect(result, tVideoData);
    });

    test('should return null when video does not exist', () async {
      when(() => mockDataSource.retrieveVideo(any(), onProgress: any(named: 'onProgress')))
          .thenAnswer((_) async => null);

      final result = await repository.retrieveVideo(tIdReview);

      expect(result, null);
    });

    test('should throw Exception when data source throws', () async {
      when(() => mockDataSource.retrieveVideo(any(), onProgress: any(named: 'onProgress')))
          .thenThrow(Exception());

      expect(
            () => repository.retrieveVideo(tIdReview),
        throwsException,
      );
    });
  });

  group('retrieveMetadata', () {
    const String tIdReview = '123';

    test('should return MultimediaMetadata with correct values', () async {
      final tResponse = MetadataResponse()
        ..numFotos = 5
        ..numVideos = 1;

      when(() => mockDataSource.retrieveMetadata(any()))
          .thenAnswer((_) async => tResponse);

      final result = await repository.retrieveMetadata(tIdReview);

      expect(result, isA<MultimediaMetadata>());
      expect(result.numFotos, 5);
      expect(result.numVideos, 1);
    });

    test('should throw Exception when data source throws', () async {
      when(() => mockDataSource.retrieveMetadata(any())).thenThrow(Exception());

      expect(
            () => repository.retrieveMetadata(tIdReview),
        throwsException,
      );
    });
  });

  group('deleteFiles', () {
    const String tIdReview = '123';

    test('should complete successfully when response success is true', () async {
      final tResponse = EliminarArchivosResponse()
        ..success = true
        ..message = 'deleted';

      when(() => mockDataSource.deleteFiles(any()))
          .thenAnswer((_) async => tResponse);

      expect(
            () => repository.deleteFiles(tIdReview),
        returnsNormally,
      );
    });

    test('should throw Exception when response success is false', () async {
      final tResponse = EliminarArchivosResponse()
        ..success = false
        ..message = 'failed delete';

      when(() => mockDataSource.deleteFiles(any()))
          .thenAnswer((_) async => tResponse);

      expect(
            () => repository.deleteFiles(tIdReview),
        throwsException,
      );
    });
  });
}