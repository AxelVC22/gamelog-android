import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppMyReviewCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback? onTap;
  final DateTime date;

  const AppMyReviewCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.onTap,
    required this.date,
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
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.videogame_asset, size: 32),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Text(
                    name,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
