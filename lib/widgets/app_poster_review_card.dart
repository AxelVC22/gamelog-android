import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/domain/entities/review.dart';
import 'app_review_card.dart';
import 'app_start_rating.dart';

class AppPosterReviewCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback? onTap;
  final DateTime date;
  final double rating;
  final String opinion;
  final Review review;

  const AppPosterReviewCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.onTap,
    required this.date,
    required this.rating,
    required this.opinion,
    required this.review
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageUrl.isNotEmpty
                    ? Image.network(imageUrl, height: 400, fit: BoxFit.cover)
                    : Container(
                        height: 150,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.videogame_asset, size: 48),
                      ),
              ),
              const SizedBox(height: 12),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  AppStarRating(rating: rating, onRatingChanged: (_) {}),
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        DateFormat('dd/MM/yyyy').format(date),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        opinion,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      ReviewItem(review: review)

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
