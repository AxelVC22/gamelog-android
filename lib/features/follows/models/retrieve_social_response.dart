import 'package:flutter/cupertino.dart';

import '../../../core/domain/entities/account.dart';

@immutable
class RetrieveSocialResponse {
  final String? message;
  final bool error;
  final List<Account> accounts;

  const RetrieveSocialResponse({
    this.message,
    required this.error,
    required this.accounts,
  });

  factory RetrieveSocialResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> accountsJson =
    (json['seguidos'] ?? json['seguidores'] ?? []) as List<dynamic>;

    return RetrieveSocialResponse(
      message: json['mensaje'] as String?,
      error: json['error'] as bool,
      accounts: accountsJson
        .map((item) => Account.fromJson(item))
    .toList(),
    );
  }
}
