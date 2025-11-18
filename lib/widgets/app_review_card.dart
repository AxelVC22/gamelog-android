import 'package:flutter/material.dart';
import 'package:gamelog/widgets/app_icon_button.dart';
import 'package:intl/intl.dart';

import 'app_like_button.dart';
import 'app_start_rating.dart';

class AppReviewCard extends StatelessWidget {
  final String username;
  final String imageUrl;
  final VoidCallback? onTap;
  final DateTime date;
  final double rating;
  final String opinion;
  final VoidCallback? onDelete;

  const AppReviewCard({
    super.key,
    required this.username,
    required this.imageUrl,
    this.onTap,
    required this.date,
    required this.rating,
    required this.opinion,
    required this.onDelete
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
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl)
                    : null,
                child: imageUrl.isEmpty
                    ? const Icon(Icons.person, size: 32)
                    : null,
              ),
              const SizedBox(width: 16),

              Column(
                children: [
                  AppStarRating(rating: rating, onRatingChanged: (_) {}),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(date),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  Text(
                    opinion,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              AppLikeButton(
                initialValue: true,
                onChanged: (value) {
                },
              ),
              AppIconButton(
                icon: Icons.delete,
                onPressed: onDelete,
              )
            ],
          ),


        ),
      ),
    );
  }
}
