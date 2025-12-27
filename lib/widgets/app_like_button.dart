import 'package:flutter/material.dart';

class AppLikeButton extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final double size;

  const AppLikeButton({
    super.key,
    this.initialValue = false,
    this.onChanged,
    this.size = 24,
  });

  @override
  State<AppLikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<AppLikeButton>
    with SingleTickerProviderStateMixin {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.initialValue;
  }

  void toggle() {
    setState(() => isLiked = !isLiked);
    widget.onChanged?.call(isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isLiked),
          color: isLiked ? Colors.red : Colors.grey,
          size: widget.size,

        ),
      ),
    );
  }
}
