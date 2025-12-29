import 'package:flutter/cupertino.dart';

import '../../../domain/entities/account.dart';

@immutable
class LogoutResponse {
  final String message;
  final bool error;


  const LogoutResponse({
    required this.message,
    required this.error,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,

    );
  }
}
