import 'package:flutter/material.dart';

class AppPasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;     // ← AGREGAR
  final String? errorText;                     // ← AGREGAR

  const AppPasswordField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.enabled = true,
    this.validator,
    this.onChanged,      // ← AGREGAR
    this.errorText,      // ← AGREGAR
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

  void _handleChange(String value) {
    // ✅ Llama a validator si existe
    if (widget.validator != null) {
      _validate(value);
    }

    // ✅ Llama a onChanged si existe
    if (widget.onChanged != null) {
      widget.onChanged!(value);
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
          onChanged: _handleChange,  // ← CAMBIAR
          decoration: InputDecoration(
            hintText: widget.hint,
            // ✅ Prioriza errorText externo sobre el interno
            errorText: widget.errorText ?? _errorText,
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