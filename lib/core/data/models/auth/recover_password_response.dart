import 'package:flutter/cupertino.dart';

@immutable
class RecoverPasswordResponse {
  final String message;
  final int? idAccess;
  final bool error;
  final int? step;

  const RecoverPasswordResponse({
    required this.message,
    this.idAccess,
    required this.error,
    this.step
});

  factory RecoverPasswordResponse.fromJson(Map<String, dynamic> json) {
    return RecoverPasswordResponse(
      message: json['mensaje'] as String,
      idAccess: json['idAcceso'] as int?,
      error: json['error'] as bool
    );
  }
}