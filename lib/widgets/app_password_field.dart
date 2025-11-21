import 'package:flutter/material.dart';

class AppPasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool enabled;

  final String? Function(String?)? validator;

  const AppPasswordField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.enabled = true,
    this.validator,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscure = true;

  String? _errorText;

  void _validate(String? value) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: _obscure,
          onChanged: _validate,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: _errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscure ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscure = !_obscure;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
