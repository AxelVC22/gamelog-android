
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

@immutable
class GetIdAccessResponse {
  final bool error;
  final int idAccess;


  const GetIdAccessResponse({
    required this.error,
    required this.idAccess

  });

  factory GetIdAccessResponse.fromJson(Map<String, dynamic> json) {
    return GetIdAccessResponse(
      error: json['error'] as bool,
      idAccess: json['idAcceso'] as int,

    );
  }
}