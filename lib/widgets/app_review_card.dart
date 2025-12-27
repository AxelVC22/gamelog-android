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
  final bool isLiked;
  final String userType;
  final int likes;
  final VoidCallback? onLiked;

  const AppReviewCard({
    super.key,
    required this.username,
    required this.imageUrl,
    this.onTap,
    required this.date,
    required this.rating,
    required this.opinion,
    required this.onDelete,
    required this.isLiked,
    required this.userType,
    required this.likes,
    this.onLiked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : null,
                        child: imageUrl.isEmpty
                            ? const Icon(Icons.person, size: 24)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (userType == 'Administrador')
                        AppIconButton(
                          icon: Icons.highlight_remove_rounded,
                          onPressed: onDelete,
                        ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      const SizedBox(height: 36),

                      AppStarRating(rating: rating, onRatingChanged: (_) {}),
                      const SizedBox(width: 8),

                      Text(
                        DateFormat('dd/MM/yyyy').format(date),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    opinion,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppLikeButton(
                    initialValue: isLiked,
                    onChanged: (value) {
                      onLiked!();
                    },
                  ),
                  Text(likes.toString(), style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
