import 'package:flutter/cupertino.dart';

import '../../../core/domain/entities/account.dart';

@immutable
class EditProfileResponse {
  final String message;
  final bool error;

  const EditProfileResponse({
    required this.message,
    required this.error,
  });

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,

    );
  }
}
