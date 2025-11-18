import 'package:flutter/material.dart';

class AppModuleTitle extends StatelessWidget {
  final String title;

  const AppModuleTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
