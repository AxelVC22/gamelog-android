import 'package:flutter/material.dart';

class AppStarRating extends StatelessWidget {
  final double rating;
  final Function(double?)? onRatingChanged;
  final double size;

  const AppStarRating({
    super.key,
    required this.rating,
    this.onRatingChanged,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        double starValue = index + 1;

        IconData icon;

        if (rating >= starValue) {
          icon = Icons.star;
        } else if (rating >= starValue - 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }

        return GestureDetector(
          onTapDown: (details) {
            if (onRatingChanged == null) return;

            double localX = details.localPosition.dx;

            if (localX < size / 2) {
              onRatingChanged!(starValue - 0.5);
            } else {
              onRatingChanged!(starValue.toDouble());
            }
          },
          child: Icon(
            icon,
            size: size,
            color: Colors.amber,
          ),
        );
      }),
    );
  }
}
