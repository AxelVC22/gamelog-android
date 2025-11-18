import 'package:flutter/material.dart';

class AppModuleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const AppModuleButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? Colors.blueAccent;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110,
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: effectiveColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: effectiveColor.withOpacity(0.4), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: effectiveColor),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: effectiveColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
