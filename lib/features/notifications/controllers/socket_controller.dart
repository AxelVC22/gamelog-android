import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/core/constants/api_constants.dart';
import '../../../core/data/repositories/sockets/notifications/socket_repository.dart';
import '../../../core/services/notification_service.dart';
import '../../auth/state/auth_state.dart';

class SocketState {
  final bool isConnected;
  final String? lastNotification;
  final String? lastAction;

  SocketState({
    this.isConnected = false,
    this.lastNotification,
    this.lastAction,
  });

  SocketState copyWith({
    bool? isConnected,
    String? lastNotification,
    String? lastAction,
    AuthNotifier? authNotifier,
  }) {
    return SocketState(
      isConnected: isConnected ?? this.isConnected,
      lastNotification: lastNotification ?? this.lastNotification,
      lastAction: lastAction ?? this.lastAction,
    );
  }
}

class SocketController extends StateNotifier<SocketState> {
  final SocketRepository repository;
  final NotificationService notificationService;
  final AuthNotifier authNotifier;

  SocketController({
    required this.repository,
    required this.notificationService,
    required this.authNotifier,
  }) : super(SocketState()) {
    _setupListeners();
  }

  void _setupListeners() {
    repository.setOnPlayerNotification((data) {
      _handlePlayerNotification(data);
    });

    repository.setOnReviewsUpdating((data) {
      _handleReviewsUpdating(data);
    });

    repository.setOnBroadcastMessage((data) {
      _handleMensajeBroadcast(data);
    });
  }

  void connect({
    required String user,
    required String password,
    required String idPlayer,
  }) {
    repository.connect(user: user, password: password, idPlayer: idPlayer);

    state = state.copyWith(isConnected: true);
  }

  void _handlePlayerNotification(dynamic data) {
    if (data is! List || data.isEmpty) return;

    final payload = data.first;

    final message = payload['mensaje'];
    final action = payload['accion'];

    if (message is! String || action is! String) return;

    state = state.copyWith(lastNotification: message, lastAction: action);

    if (action != 'Eliminar_seguidor') {
      notificationService.showNotification(
        title: ApiConstants.appName,
        message: message,
      );
    }

    if (action == 'Banear_usuario') {
      _handleBan();
    }
  }

  void _handleReviewsUpdating(dynamic data) {
    if (data is! List || data.isEmpty) return;

    final payload = data.first;
    if (payload is! Map) return;

    final message = payload['mensaje'];
    final action = payload['accion'];

    if (message is! String || action is! String) return;

    state = state.copyWith(lastNotification: message, lastAction: action);

    notificationService.showNotification(
      title: ApiConstants.appName,
      message: message,
    );
  }

  void _handleMensajeBroadcast(dynamic data) {
    String mensaje = '';

    if (data is Map) {
      mensaje = data['mensaje'] ?? '';
    } else if (data is String) {
      mensaje = data;
    }

    notificationService.showNotification(
      title: ApiConstants.appName,
      message: mensaje,
    );
  }

  void _handleBan() {
    disconnect();
    authNotifier.expired();
  }

  void subscribeGameReviews(String idGame) {
    repository.subscribeGameReviews(idGame);
  }

  void unsubscribeGameReviews(String idGame) {
    repository.unsubscribeGameReviews(idGame);
  }

  void subscribeBroadcast() {
    repository.subscribeBroadcast();
  }

  void disconnect() {
    repository.disconnect();
    state = state.copyWith(isConnected: false);
  }
}
