

class ReviewGameResponse {
  final String message;
  final bool error;

  const ReviewGameResponse({
    required this.message,
    required this.error,
  });

  factory ReviewGameResponse.fromJson(Map<String, dynamic> json) {
    return ReviewGameResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,
    );
  }
}
