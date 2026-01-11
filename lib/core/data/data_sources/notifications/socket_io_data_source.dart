import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../services/notification_service.dart';

class SocketIODataSource {
  IO.Socket? _socket;
  String? _idJugador;
  final NotificationService _notificationService;

  SocketIODataSource({
    IO.Socket? socket,
    NotificationService? notificationService,
  })  : _socket = socket,
        _notificationService = notificationService ?? NotificationService();

  Function(String)? onNotificacionJugador;
  Function(String)? onActualizacionResenas;
  Function(String)? onMensajeBroadcast;

  void connect({
    required String usuario,
    required String contrasenia,
    required String idJugador,
  }) {
    _idJugador = idJugador;

    _socket ??= IO.io(
      'http://192.168.0.24:1236',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({
        'usuario': usuario,
        'contrasenia': contrasenia,
      })
          .build(),
    );

    _socket!.on('connect', (_) {
      print('Socket conectado');
      _socket!.emit('suscribir_notificacion_jugador', idJugador);
    });

    _socket!.on('notificacion_jugador', (data) {
      if (data is List && data.isNotEmpty) {
        final payload = data[0];

        if (payload is Map) {
          final accion = payload['accion'];
          final mensaje = payload['mensaje'];

          _notificationService.mostrarNotificacion(
            titulo: _tituloPorAccion(accion.toString()),
            mensaje: mensaje ?? 'Nueva notificación',
          );
        }
      }
    });

    _socket!.on('actualizacion_resenas', (data) {
      print('Actualización de reseñas: $data');
      if (onActualizacionResenas != null) {
        onActualizacionResenas!(data.toString());
      }
    });

    _socket!.on('mensaje_broadcast', (data) {
      print('Mensaje broadcast: $data');
      if (onMensajeBroadcast != null) {
        onMensajeBroadcast!(data.toString());
      }
    });

    _socket!.on('disconnect', (_) {
      print('Socket desconectado');
    });

    _socket!.on('connect_error', (error) {
      print('Error de conexión: $error');
    });

    _socket!.connect();
  }

  void suscribirResenasJuego(String idJuego) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('suscribir_interaccion_resenas', idJuego);
    }
  }

  void desuscribirResenasJuego(String idJuego) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('desuscribir_interaccion_resenas', idJuego);
    }
  }

  void suscribirBroadcast() {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('broadcast_mensajes_servidor');
    }
  }

  void desuscribirNotificacionJugador() {
    if (_socket != null && _socket!.connected && _idJugador != null) {
      _socket!.emit('desuscribir_notificacion_jugador', _idJugador);
    }
  }

  void disconnect() {
    if (_socket != null) {
      if (_socket!.connected) {
        desuscribirNotificacionJugador();
        _socket!.disconnect();
      }
      try {
        _socket!.dispose();
      } catch (e) {}
      _socket = null;
    }
  }

  bool get isConnected => _socket != null && _socket!.connected;

  String _tituloPorAccion(String accion) {
    return 'Titulo';
  }
}