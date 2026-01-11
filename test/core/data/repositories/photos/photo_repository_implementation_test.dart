import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gamelog/core/data/repositories/photos/photo_repository.dart';
import 'package:gamelog/core/data/repositories/photos/photo_repository_implementation.dart';
import 'package:gamelog/core/data/data_sources/photo_grpc_data_source.dart';
import 'package:gamelog/grpc/Fotos_De_Perfil.pb.dart';

class MockPhotoGrpcDataSource extends Mock implements PhotoGrpcDataSource {}

void main() {
  late PhotoRepositoryImpl repository;
  late MockPhotoGrpcDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  setUp(() {
    mockDataSource = MockPhotoGrpcDataSource();
    repository = PhotoRepositoryImpl(mockDataSource);
  });

  group('savePhoto', () {
    const String tPlayerId = '123';
    final Uint8List tImageData = Uint8List.fromList([1, 2, 3]);

    test('should return true when data source returns success true', () async {
      final tResponse = FotoResponse()..success = true;
      when(() => mockDataSource.savePhoto(
        playerId: any(named: 'playerId'),
        imageData: any(named: 'imageData'),
      )).thenAnswer((_) async => tResponse);

      final result = await repository.savePhoto(tPlayerId, tImageData);
      expect(result, true);
    });

    test('should return false when data source returns success false', () async {
      final tResponse = FotoResponse()..success = false;
      when(() => mockDataSource.savePhoto(
        playerId: any(named: 'playerId'),
        imageData: any(named: 'imageData'),
      )).thenAnswer((_) async => tResponse);

      final result = await repository.savePhoto(tPlayerId, tImageData);
      expect(result, false);
    });

    test('should throw Exception when data source fails', () async {
      when(() => mockDataSource.savePhoto(
        playerId: any(named: 'playerId'),
        imageData: any(named: 'imageData'),
      )).thenThrow(Exception());

      expect(() => repository.savePhoto(tPlayerId, tImageData), throwsException);
    });
  });

  group('getPhoto', () {
    const String tPlayerId = '123';

    test('should return PhotoResult with user data when available', () async {
      final tResponse = FotoResponse()
        ..datos = [10, 20]
        ..esDefault = false
        ..message = 'Success';
      when(() => mockDataSource.getPhoto(any())).thenAnswer((_) async => tResponse);

      final result = await repository.getPhoto(tPlayerId);
      expect(result.imageData, Uint8List.fromList([10, 20]));
      expect(result.isDefault, false);
    });

    test('should return PhotoResult with default flag when user has no photo', () async {
      final tResponse = FotoResponse()
        ..datos = [0, 0]
        ..esDefault = true
        ..message = 'Default';
      when(() => mockDataSource.getPhoto(any())).thenAnswer((_) async => tResponse);

      final result = await repository.getPhoto(tPlayerId);
      expect(result.isDefault, true);
    });

    test('should throw Exception when getPhoto fails', () async {
      when(() => mockDataSource.getPhoto(any())).thenThrow(Exception());
      expect(() => repository.getPhoto(tPlayerId), throwsException);
    });
  });

  group('getMultiplePhotos', () {
    final tPlayerIds = ['1', '2'];

    test('should return map with correct mapping of user and default photos', () async {
      final tFoto1 = FotoInfo()
        ..idJugador = '1'
        ..tieneFoto = true
        ..datos = [1, 1];

      final tFoto2 = FotoInfo()
        ..idJugador = '2'
        ..tieneFoto = false
        ..datos = [];

      final tResponse = MultipleFotosResponse()
        ..fotoDefault = [0, 0]
        ..fotos.addAll([tFoto1, tFoto2]);

      when(() => mockDataSource.getMultiplePhotos(any())).thenAnswer((_) async => tResponse);

      final result = await repository.getMultiplePhotos(tPlayerIds);

      expect(result['1'], Uint8List.fromList([1, 1]));
      expect(result['2'], Uint8List.fromList([0, 0]));
    });

    test('should return empty map when no IDs are provided', () async {
      final tResponse = MultipleFotosResponse()..fotoDefault = [0];
      when(() => mockDataSource.getMultiplePhotos(any())).thenAnswer((_) async => tResponse);

      final result = await repository.getMultiplePhotos([]);
      expect(result, isEmpty);
    });

    test('should throw Exception when getMultiplePhotos fails', () async {
      when(() => mockDataSource.getMultiplePhotos(any())).thenThrow(Exception());
      expect(() => repository.getMultiplePhotos(tPlayerIds), throwsException);
    });
  });
}