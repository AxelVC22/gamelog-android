import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'app_icon_button.dart';
import 'app_profile_picture.dart';

class AppSocialCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool followed;
  final Uint8List? imageData;
  final bool isLoading;

  const AppSocialCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.onTap,
    this.onDelete,
    required this.followed,
    required this.imageData,
    required this.isLoading
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [



                  AppProfilePhoto(
                    imageData: imageData,
                    isLoading: isLoading,
                    radius: 30,
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
              if (followed)
              AppIconButton(icon: Icons.person_off, onPressed: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}
