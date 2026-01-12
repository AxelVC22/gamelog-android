import 'package:gamelog/core/data/repositories/sockets/notifications/socket_repository.dart';

import '../../../data_sources/notifications/socket_io_data_source.dart';

class SocketRepositoryImpl implements SocketRepository {
  final SocketIODataSource dataSource;

  SocketRepositoryImpl(this.dataSource);

  @override
  void connect({
    required String user,
    required String password,
    required String idPlayer,
  }) {
    dataSource.connect(
      user: user,
      password: password,
      idPlayer: idPlayer,
    );
  }

  @override
  void subscribeGameReviews(String idGame) {
    dataSource.subscribeGameReviews(idGame);
  }

  @override
  void unsubscribeGameReviews(String idGame) {
    dataSource.unsubscribeGameReviews(idGame);
  }

  @override
  void subscribeBroadcast() {
    dataSource.subscribeBroadcast();
  }

  @override
  void disconnect() {
    dataSource.disconnect();
  }

  @override
  bool get isConnected => dataSource.isConnected;

  @override
  void setOnPlayerNotification(Function(dynamic) callback) {
    dataSource.onPlayerNotification = callback;
  }

  @override
  void setOnReviewsUpdating(Function(dynamic) callback) {
    dataSource.onReviewsUpdating = callback;
  }

  @override
  void setOnBroadcastMessage(Function(dynamic) callback) {
    dataSource.onBroadcastMessage = callback;
  }
}