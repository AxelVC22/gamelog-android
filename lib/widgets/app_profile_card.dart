import 'package:flutter/material.dart';

import '../features/photos/controllers/profile_photo_controller.dart';
import 'app_profile_picture.dart';

class AppProfileCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback? onTap;
  final PhotoState photoState;

  const AppProfileCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.onTap,
    required this.photoState,
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
              Stack(
                children: [
                  AppProfilePhoto(
                    imageData: photoState.imageData,
                    isLoading: photoState.isLoading,
                    radius: 30,
                  ),

                  if (photoState.isLoading)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
