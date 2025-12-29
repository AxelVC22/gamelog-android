
class AddToPendingsResponse {
  final String message;
  final bool error;

  const AddToPendingsResponse({
    required this.message,
    required this.error,
  });

  factory AddToPendingsResponse.fromJson(Map<String, dynamic> json) {
    return AddToPendingsResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,
    );
  }
}
