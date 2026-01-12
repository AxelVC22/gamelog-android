// core/providers/socket_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamelog/features/auth/state/auth_state.dart';

import '../../../../../features/notifications/controllers/socket_controller.dart';
import '../../../../services/notification_service.dart';
import '../../../data_sources/notifications/socket_io_data_source.dart';
import '../../../repositories/sockets/notifications/socket_repository.dart';
import '../../../repositories/sockets/notifications/socket_repository_implementation.dart';


// Data Source
final socketDataSourceProvider = Provider<SocketIODataSource>((ref) {
  return SocketIODataSource();
});

// Repository
final socketRepositoryProvider = Provider<SocketRepository>((ref) {
  final dataSource = ref.watch(socketDataSourceProvider);
  return SocketRepositoryImpl(dataSource);
});

// Notification Service
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

// Controller
final socketControllerProvider =
StateNotifierProvider<SocketController, SocketState>((ref) {
  final repository = ref.watch(socketRepositoryProvider);
  final notificationService = ref.watch(notificationServiceProvider);

  return SocketController(
    repository: repository,
    notificationService: notificationService,
    authNotifier: ref.read(authStateProvider.notifier)
  );
});