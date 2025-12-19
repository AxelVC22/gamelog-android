import 'package:flutter/cupertino.dart';

@immutable
class AddToBlackListRequest {
  final String email;
  final String userType;
  final String? accessStatus = "Baneado";



  const AddToBlackListRequest({
    required this.email,
    required this.userType,

  });

  Map<String, dynamic> toJson() => {
    'estadoAcceso': accessStatus,
  };
}
