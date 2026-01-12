import 'package:gamelog/core/constants/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIODataSource {
  io.Socket? _socket;
  String? _idPlayer;

  Function(dynamic)? onPlayerNotification;
  Function(dynamic)? onReviewsUpdating;
  Function(dynamic)? onBroadcastMessage;

  void connect({
    required String user,
    required String password,
    required String idPlayer,
  }) {
    _idPlayer = idPlayer;

    _socket = io.io(
      ApiConstants.webSocketsUrl,
      io.OptionBuilder().setTransports(['websocket']).setQuery({
        'usuario': user,
        'contrasenia': password,
      }).build(),
    );

    _socket!.on('connect', (_) {
      _socket!.emit('suscribir_notificacion_jugador', idPlayer);
    });

    _socket!.on('notificacion_jugador', (data) {
      if (onPlayerNotification != null) {
        onPlayerNotification!(data);
      }
    });

    _socket!.on('actualizacion_resenas', (data) {
      if (onReviewsUpdating != null) {
        onReviewsUpdating!(data);
      }
    });

    _socket!.on('mensaje_broadcast', (data) {
      if (onBroadcastMessage != null) {
        onBroadcastMessage!(data);
      }
    });


    _socket!.connect();
  }

  void subscribeGameReviews(String idGame) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('suscribir_interaccion_resenas', idGame);
    }
  }

  void unsubscribeGameReviews(String idGame) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('desuscribir_interaccion_resenas', idGame);
    }
  }

  void subscribeBroadcast() {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('broadcast_mensajes_servidor');
    }
  }

  void unsubscribePlayerNotification() {
    if (_socket != null && _socket!.connected && _idPlayer != null) {
      _socket!.emit('desuscribir_notificacion_jugador', _idPlayer);
    }
  }

  void disconnect() {
    if (_socket != null && _socket!.connected) {
      unsubscribePlayerNotification();
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
    }
  }

  bool get isConnected => _socket != null && _socket!.connected;
}