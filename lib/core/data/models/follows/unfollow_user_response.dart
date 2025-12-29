import 'package:flutter/cupertino.dart';


@immutable
class UnfollowUserResponse {
  final String message;
  final bool error;

  const UnfollowUserResponse({
    required this.message,
    required this.error,
  });

  factory UnfollowUserResponse.fromJson(Map<String, dynamic> json) {
    return UnfollowUserResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,

    );
  }
}
