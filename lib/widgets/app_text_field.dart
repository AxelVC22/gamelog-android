import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool obscure;
  final TextEditingController controller;

  const AppTextField({
    required this.label,
    required this.controller,
    this.icon,
    this.obscure = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(),
      ),
    );
  }
}
