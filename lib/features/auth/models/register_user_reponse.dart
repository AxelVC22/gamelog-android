
import 'package:flutter/cupertino.dart';

@immutable
class RegisterUserResponse {
  final String message;
  final bool error;

  const RegisterUserResponse({
    required this.message,
    required this.error,
  });

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,
    );
  }
}

