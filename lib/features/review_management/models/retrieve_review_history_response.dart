
import '../../../core/domain/entities/review.dart';

class RetrieveReviewHistoryResponse {
  final bool error;
  final List<Review> reviews;

  const RetrieveReviewHistoryResponse({
    required this.error,
    required this.reviews,
  });

  factory RetrieveReviewHistoryResponse.fromJson(Map<String, dynamic> json) {
    return RetrieveReviewHistoryResponse(
      error: json['error'] as bool,
      reviews: (json['reseñas'] as List<dynamic>)
          .map((item) => Review.fromJson(item))
          .toList(),
    );
  }
}