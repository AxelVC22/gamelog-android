import 'package:flutter/cupertino.dart';

@immutable
class AddToFavoritesResponse {
  final String message;
  final bool error;

  const AddToFavoritesResponse({
    required this.message,
    required this.error,
  });

  factory AddToFavoritesResponse.fromJson(Map<String, dynamic> json) {
    return AddToFavoritesResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,
    );
  }
}
