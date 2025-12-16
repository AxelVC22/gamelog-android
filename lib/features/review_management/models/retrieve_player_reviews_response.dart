
import '../../../core/domain/entities/review.dart';

class RetrievePlayerReviewsResponse {
  final bool error;
  final List<Review> reviews;

  const RetrievePlayerReviewsResponse({
    required this.error,
    required this.reviews,
  });

  factory RetrievePlayerReviewsResponse.fromJson(Map<String, dynamic> json) {
    return RetrievePlayerReviewsResponse(
        error: json['error'] as bool,
      reviews: (json['reseñas'] as List<dynamic>)
        .map((item) => Review.fromJson(item))
        .toList(),
    );
  }
}