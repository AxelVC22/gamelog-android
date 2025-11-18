import 'package:flutter/material.dart';

class AppProfileCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback? onTap;

  const AppProfileCard({
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
              CircleAvatar(
                radius: 28,
                backgroundImage:
                imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                child: imageUrl.isEmpty
                    ? const Icon(Icons.person, size: 32)
                    : null,
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
