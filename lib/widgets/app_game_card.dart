import 'package:flutter/material.dart';

class AppGameCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback? onTap;

  const AppGameCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.onTap,

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
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
