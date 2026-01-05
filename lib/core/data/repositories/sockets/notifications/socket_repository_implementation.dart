// data/repositories/socket_repository_impl.dart



import 'package:gamelog/core/data/repositories/sockets/notifications/socket_repository.dart';

import '../../../data_sources/notifications/socket_io_data_source.dart';

class SocketRepositoryImpl implements SocketRepository {
  final SocketIODataSource dataSource;

  SocketRepositoryImpl(this.dataSource);

  @override
  void connect({
    required String usuario,
    required String contrasenia,
    required String idJugador,
  }) {
    dataSource.connect(
      usuario: usuario,
      contrasenia: contrasenia,
      idJugador: idJugador,
    );
  }

  @override
  void suscribirResenasJuego(String idJuego) {
    dataSource.suscribirResenasJuego(idJuego);
  }

  @override
  void desuscribirResenasJuego(String idJuego) {
    dataSource.desuscribirResenasJuego(idJuego);
  }

  @override
  void suscribirBroadcast() {
    dataSource.suscribirBroadcast();
  }

  @override
  void disconnect() {
    dataSource.disconnect();
  }

  @override
  bool get isConnected => dataSource.isConnected;

  @override
  void setOnNotificacionJugador(Function(String) callback) {
    dataSource.onNotificacionJugador = callback;
  }

  @override
  void setOnActualizacionResenas(Function(String) callback) {
    dataSource.onActualizacionResenas = callback;
  }

  @override
  void setOnMensajeBroadcast(Function(String) callback) {
    dataSource.onMensajeBroadcast = callback;
  }
}