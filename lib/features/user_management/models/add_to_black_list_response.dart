import 'package:flutter/cupertino.dart';

import '../../../core/domain/entities/account.dart';

@immutable
class AddToBlackListResponse {
  final String message;
  final bool error;

  const AddToBlackListResponse({
    required this.message,
    required this.error,
  });

  factory AddToBlackListResponse.fromJson(Map<String, dynamic> json) {
    return AddToBlackListResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,

    );
  }
}
