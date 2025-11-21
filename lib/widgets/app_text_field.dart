import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool obscure;
  final TextEditingController controller;
  final String? errorText;
  final void Function(String value)? onChanged;

  const AppTextField({
    required this.label,
    required this.controller,
    this.icon,
    this.obscure = false,
    this.errorText,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: const OutlineInputBorder(),
        errorText: errorText,
      ),
    );
  }
}