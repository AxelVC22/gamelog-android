import 'package:flutter/cupertino.dart';

@immutable
class FollowUserRequest {
  final int idPlayerFollower;
  final int idPlayerFollowed;



  const FollowUserRequest({
    required this.idPlayerFollower,
    required this.idPlayerFollowed,

  });

  Map<String, dynamic> toJson() => {
    'idJugadorSeguidor': idPlayerFollower,
    'idJugadorSeguido': idPlayerFollowed
  };
}
