
abstract class SocketRepository {
  void connect({
    required String user,
    required String password,
    required String idPlayer,
  });

  void subscribeGameReviews(String idGame);
  void unsubscribeGameReviews(String idGame);
  void subscribeBroadcast();
  void disconnect();

  bool get isConnected;

  void setOnPlayerNotification(Function(dynamic) callback);
  void setOnReviewsUpdating(Function(dynamic) callback);
  void setOnBroadcastMessage(Function(dynamic) callback);
}