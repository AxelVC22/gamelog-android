import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
class AppPhoto extends StatelessWidget {
  final Uint8List imageData;
  final bool isVideo;
  final VoidCallback? onRemove;
  final bool isEditable;

  const AppPhoto({
    super.key,
    required this.imageData,
    this.isVideo = false,
    this.onRemove,
    required this.isEditable
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              imageData,
              fit: BoxFit.cover,
            ),
          ),
        ),

        if (isVideo)
          const Center(
            child: Icon(
              Icons.play_circle_fill,
              color: Colors.white,
              size: 48,
            ),
          ),

        if (isEditable)
        Positioned(
          top: 6,
          right: 6,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
