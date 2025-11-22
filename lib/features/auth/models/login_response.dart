import 'package:flutter/cupertino.dart';

import '../../../core/domain/entities/account.dart';

@immutable
class LoginResponse {
  final String? message;
  final bool error;
  final List<Account> accounts;

  const LoginResponse({
    this.message,
    required this.error,
    required this.accounts,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['mensaje'] as String?,
      error: json['error'] as bool,
      accounts: (json['cuenta'] as List<dynamic>)
          .map((item) => Account.fromJson(item))
          .toList(),
    );
  }
}
