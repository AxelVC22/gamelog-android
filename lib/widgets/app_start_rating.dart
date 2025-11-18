import 'package:flutter/material.dart';

class AppStarRating extends StatelessWidget {
  final double rating; // 0.0 a 5.0
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
          icon = Icons.star;               // estrella llena
        } else if (rating >= starValue - 0.5) {
          icon = Icons.star_half;          // media estrella
        } else {
          icon = Icons.star_border;        // vacía
        }

        return GestureDetector(
          onTapDown: (details) {
            if (onRatingChanged == null) return;

            double localX = details.localPosition.dx;

            // Presiona en la mitad izquierda → media estrella
            // Presiona en la mitad derecha → estrella completa
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
