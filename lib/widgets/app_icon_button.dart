import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double padding;
  final Color? color;
  final Color? backgroundColor;
  final double borderRadius;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 32,
    this.padding = 4,
    this.color,
    this.backgroundColor,
    this.borderRadius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Icon(
          icon,
          size: size,

        ),
      ),
    );
  }
}
