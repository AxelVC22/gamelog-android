// features/notifications/controllers/socket_controller.dart

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/repositories/sockets/notifications/socket_repository.dart';
import '../../../core/services/notification_service.dart';

class SocketState {
  final bool isConnected;
  final String? lastNotification;

  SocketState({
    this.isConnected = false,
    this.lastNotification,
  });

  SocketState copyWith({
    bool? isConnected,
    String? lastNotification,
  }) {
    return SocketState(
      isConnected: isConnected ?? this.isConnected,
      lastNotification: lastNotification ?? this.lastNotification,
    );
  }
}

class SocketController extends StateNotifier<SocketState> {
  final SocketRepository repository;
  final NotificationService notificationService;

  SocketController({
    required this.repository,
    required this.notificationService,
  }) : super(SocketState()) {
    _setupListeners();
  }

  void _setupListeners() {
    // Listener de notificaciones
    repository.setOnNotificacionJugador((data) {
      _handleNotificacionJugador(data);
    });

    // Listener de actualización de reseñas
    repository.setOnActualizacionResenas((data) {
      _handleActualizacionResenas(data);
    });

    // Listener de broadcast
    repository.setOnMensajeBroadcast((data) {
      _handleMensajeBroadcast(data);
    });
  }

  void connect({
    required String usuario,
    required String contrasenia,
    required String idJugador,
  }) {
    repository.connect(
      usuario: usuario,
      contrasenia: contrasenia,
      idJugador: idJugador,
    );

    state = state.copyWith(isConnected: true);
  }

  void _handleNotificacionJugador(String data) {
    try {
      final json = jsonDecode(data);
      final mensaje = json['mensaje'] ?? '';
      final accion = json['accion'] ?? '';

      // Actualizar estado
      state = state.copyWith(lastNotification: mensaje);

      // Mostrar notificación local (excepto si es eliminar seguidor)
      if (accion != 'eliminar_seguidor') {
        notificationService.mostrarNotificacion(
          titulo: 'Notificación',
          mensaje: mensaje,
        );
      }

      // Manejar baneo
      if (accion == 'banear_usuario') {
        _handleBaneo();
      }
    } catch (e) {
      print('Error parseando notificación: $e');
    }
  }

  void _handleActualizacionResenas(String data) {
    print('Actualización de reseñas recibida: $data');
    // Aquí puedes emitir un evento para refrescar la lista de reseñas
    // O usar un RefreshNotifier, etc.
  }

  void _handleMensajeBroadcast(String data) {
    try {
      final json = jsonDecode(data);
      final mensaje = json['mensaje'] ?? '';

      notificationService.mostrarNotificacion(
        titulo: 'Mensaje del servidor',
        mensaje: mensaje,
      );
    } catch (e) {
      print('Error parseando broadcast: $e');
    }
  }

  void _handleBaneo() {
    // Aquí implementas la lógica de logout
    disconnect();
    // Navegar a login, limpiar shared prefs, etc.
  }

  void suscribirResenasJuego(String idJuego) {
    repository.suscribirResenasJuego(idJuego);
  }

  void desuscribirResenasJuego(String idJuego) {
    repository.desuscribirResenasJuego(idJuego);
  }

  void suscribirBroadcast() {
    repository.suscribirBroadcast();
  }

  void disconnect() {
    repository.disconnect();
    state = state.copyWith(isConnected: false);
  }
}