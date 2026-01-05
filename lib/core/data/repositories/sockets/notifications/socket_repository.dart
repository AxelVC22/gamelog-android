// domain/repositories/socket_repository.dart

abstract class SocketRepository {
  void connect({
    required String usuario,
    required String contrasenia,
    required String idJugador,
  });

  void suscribirResenasJuego(String idJuego);
  void desuscribirResenasJuego(String idJuego);
  void suscribirBroadcast();
  void disconnect();
  bool get isConnected;

  // Callbacks
  void setOnNotificacionJugador(Function(String) callback);
  void setOnActualizacionResenas(Function(String) callback);
  void setOnMensajeBroadcast(Function(String) callback);
}