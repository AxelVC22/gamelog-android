class LikeResponse {
  final String message;
  final bool error;
  final int? idReview;

  const LikeResponse({
    required this.message,
    required this.error,
    this.idReview,
  });

  factory LikeResponse.fromJson(Map<String, dynamic> json) {
    return LikeResponse(
      message: json['mensaje'] as String,
      error: json['error'] as bool,
    );
  }


  LikeResponse copyWith({
    int? idReview,
  }) {
    return LikeResponse(
      error: error,
      message: message,
      idReview: idReview ?? this.idReview,
    );
  }
}

