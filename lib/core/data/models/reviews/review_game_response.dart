

class ReviewGameResponse {
  final String message;
  final bool error;
  final int idReview;

  const ReviewGameResponse({
    required this.message,
    required this.error,
    required this.idReview
  });

  factory ReviewGameResponse.fromJson(Map<String, dynamic> json) {
    return ReviewGameResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,
      idReview: json['idResenia'] as int
    );
  }
}
