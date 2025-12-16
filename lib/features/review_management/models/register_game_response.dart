
class RegisterGameResponse {
  final String message;
  final bool error;

  const RegisterGameResponse({
    required this.message,
    required this.error,
  });

  factory RegisterGameResponse.fromJson(Map<String, dynamic> json) {
    return RegisterGameResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,
    );
  }
}
