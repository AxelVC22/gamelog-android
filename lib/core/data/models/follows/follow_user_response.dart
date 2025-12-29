import 'package:flutter/cupertino.dart';


@immutable
class FollowUserResponse {
  final String message;
  final bool error;

  const FollowUserResponse({
    required this.message,
    required this.error,
  });

  factory FollowUserResponse.fromJson(Map<String, dynamic> json) {
    return FollowUserResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,

    );
  }
}
