import 'package:flutter/material.dart';

class AppLinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final double fontSize;

  const AppLinkText({
    super.key,
    required this.text,
    required this.onTap,
    this.color = Colors.blue,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
