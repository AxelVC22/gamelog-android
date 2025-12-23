import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class AppFilterTab extends StatefulWidget {
  final List<String> options;
  final ValueChanged<int>? onChanged;
  final int initialIndex;

  const AppFilterTab({
    super.key,
    required this.options,
    this.onChanged,
    this.initialIndex = 0,
  });

  @override
  State<AppFilterTab> createState() => _AppFilterTabState();
}

class _AppFilterTabState extends State<AppFilterTab> {
  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.options.length,
            (index) {
          final isActive = index == selected;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() => selected = index);
                widget.onChanged?.call(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.buttonSecondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.options[index],
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
