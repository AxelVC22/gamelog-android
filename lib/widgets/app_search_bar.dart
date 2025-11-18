import 'dart:async';
import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  final Function(String query) onSearch;
  final String hint;

  const AppSearchBar({
    Key? key,
    required this.onSearch,
    this.hint = "Buscar...",
  }) : super(key: key);

  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  Timer? _debounce;

  void _onChanged(String value) {
    // Cancela el anterior delay
    _debounce?.cancel();

    // Espera 400ms para ver si el usuario deja de escribir
    _debounce = Timer(const Duration(milliseconds: 400), () {
      widget.onSearch(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onChanged,
      decoration: InputDecoration(
        labelText: widget.hint,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
