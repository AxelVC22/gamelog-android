import 'package:flutter/cupertino.dart';

@immutable
class LoginResponse {
  final String message;
  final bool error;

  const LoginResponse({
    required this.message,
    required this.error,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,
    );
  }
}
