
import 'package:grpc/grpc.dart';
import 'dart:typed_data';
import '../../../grpc/Multimedia_De_Resenia.pbgrpc.dart';

class ReviewMultimediaGrpcDataSource {
  late ClientChannel _channel;
  late ReviewMultimediaClient _stub;
  static const int chunkSize = 64 * 1024;

  ReviewMultimediaGrpcDataSource({required String host, required int port}) {
    _channel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _stub = ReviewMultimediaClient(_channel);
  }


  Future<SubirFotoResponse> uploadPhoto({
    required String idReview,
    required int indice,
    required String extension,
    required Uint8List data,
  }) async {
    try {
      final request = SubirFotoRequest()
        ..idReview = idReview
        ..indice = indice
        ..extension_3 = extension
        ..datos = data;

      return await _stub.subirFoto(request);
    } on GrpcError catch (e) {
      throw Exception('Error gRPC: ${e.message}');
    }
  }

  Future<ObtenerFotosResponse> retrievePhotos(String idReview) async {
    try {
      final request = ObtenerFotosRequest()..idReview = idReview;
      return await _stub.obtenerFotos(request);
    } on GrpcError catch (e) {
      throw Exception('Error gRPC: ${e.message}');
    }
  }


  Future<SubirVideoResponse> uploadVideo({
    required String idReview,
    required String extension,
    required Uint8List videoData,
    Function(double)? onProgress,
  }) async {
    try {
      final totalChunks = (videoData.length / chunkSize).ceil();

      Stream<ChunkVideoRequest> requestStream() async* {
        for (int i = 0; i < totalChunks; i++) {
          final start = i * chunkSize;
          final end = (start + chunkSize < videoData.length)
              ? start + chunkSize
              : videoData.length;

          final chunk = videoData.sublist(start, end);

          yield ChunkVideoRequest()
            ..idReview = idReview
            ..extension_2 = extension
            ..chunk = chunk
            ..chunkIndex = i
            ..totalChunks = totalChunks;

          if (onProgress != null) {
            onProgress((i + 1) / totalChunks);
          }
        }
      }

      return await _stub.subirVideo(requestStream());
    } on GrpcError catch (e) {
      throw Exception('Error gRPC: ${e.message}');
    }
  }

  Future<Uint8List?> retrieveVideo(
      String idReview, {
        Function(double)? onProgress,
      }) async {
    try {
      final request = ObtenerVideoRequest()..idReview = idReview;
      final stream = _stub.obtenerVideo(request);

      final chunks = <Uint8List>[];
      int totalChunks = 0;
      int receivedChunks = 0;

      await for (final chunk in stream) {
        if (totalChunks == 0) {
          totalChunks = chunk.totalChunks;
        }

        chunks.add(Uint8List.fromList(chunk.chunk));
        receivedChunks++;

        if (onProgress != null && totalChunks > 0) {
          onProgress(receivedChunks / totalChunks);
        }
      }

      if (chunks.isEmpty) return null;

      final totalLength = chunks.fold<int>(0, (sum, chunk) => sum + chunk.length);
      final result = Uint8List(totalLength);
      int offset = 0;
      for (final chunk in chunks) {
        result.setRange(offset, offset + chunk.length, chunk);
        offset += chunk.length;
      }

      return result;
    } on GrpcError catch (e) {
      throw Exception('Error gRPC: ${e.message}');
    }
  }


  Future<MetadataResponse> retrieveMetadata(String idReview) async {
    try {
      final request = ObtenerMetadataRequest()..idReview = idReview;
      return await _stub.obtenerMetadata(request);
    } on GrpcError catch (e) {
      throw Exception('Error gRPC: ${e.message}');
    }
  }

  Future<EliminarArchivosResponse> deleteFiles(String idReview) async {
    try {
      final request = EliminarArchivosRequest()..idReview = idReview;
      return await _stub.eliminarArchivos(request);
    } on GrpcError catch (e) {
      throw Exception('Error gRPC: ${e.message}');
    }
  }

  Future<void> close() async {
    await _channel.shutdown();
  }
}