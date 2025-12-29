
class DeleteReviewResponse {
  final bool error;
  final int? status;
  final String message;
  final int? idReview;

  const DeleteReviewResponse({
    required this.error,
    this.status,
    required this.message,
    this.idReview
  });

  factory DeleteReviewResponse.fromJson(Map<String, dynamic> json) {

    return DeleteReviewResponse(
      error: json['error'] as bool,
      status: json['estado'] as int?,
      message: json['mensaje'] as String,
    );
  }

  DeleteReviewResponse copyWith({
    int? idReview,
  }) {
    return DeleteReviewResponse(
      error: error,
      message: message,
      idReview: idReview ?? this.idReview,
    );
  }
}

