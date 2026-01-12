import 'package:grpc/grpc.dart';
import 'dart:typed_data';

import '../../../../grpc/Fotos_De_Perfil.pbgrpc.dart';
class PhotoGrpcDataSource {
  late ClientChannel _channel;
  late FotosDePerfilClient _stub;

  PhotoGrpcDataSource({required String host, required int port}) {
    _channel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _stub = FotosDePerfilClient(_channel);
  }

  Future<FotoResponse> savePhoto({
    required String playerId,
    required Uint8List imageData,
  }) async {
    try {
      final request = FotoRequest()
        ..idJugador = playerId
        ..datos = imageData;

      return await _stub.subirFoto(request);
    } on GrpcError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<FotoResponse> getPhoto(String playerId) async {
    try {
      final request = FotoRequest()
        ..idJugador = playerId;

      return await _stub.obtenerFoto(request);
    } on GrpcError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<MultipleFotosResponse> getMultiplePhotos(List<String> playerIds) async {
    try {
      final request = MultipleFotosRequest()..idsJugadores.addAll(playerIds);
      return await _stub.obtenerMultiplesFotos(request);
    } on GrpcError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> close() async {
    await _channel.shutdown();
  }
}