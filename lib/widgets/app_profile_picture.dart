import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gamelog/widgets/app_skeleton_loader.dart';


class AppProfilePhoto extends StatelessWidget {
  final Uint8List? imageData;
  final bool isLoading;
  final double radius;

  const AppProfilePhoto({
    super.key,
    required this.imageData,
    required this.isLoading,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (!isLoading && imageData != null)
          ? () => _showFullImage(context, imageData!)
          : null,
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: ClipOval(
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (isLoading)
                AppSkeletonLoader.circle(size: radius)
              else if (imageData != null)
                Image.memory(imageData!, fit: BoxFit.cover)
              else
                Container(color: Colors.grey[300]),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context, Uint8List image) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: InteractiveViewer(child: Image.memory(image)),
        ),
      ),
    );
  }
}
