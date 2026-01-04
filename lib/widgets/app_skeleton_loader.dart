import 'package:flutter/material.dart';
import 'package:gamelog/core/constants/app_colors.dart';


class AppSkeletonLoader extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const AppSkeletonLoader({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  }) : super(key: key);

  const AppSkeletonLoader.text({
    Key? key,
    double width = 100,
    double height = 16,
  }) : this(
    key: key,
    width: width,
    height: height,
    borderRadius: const BorderRadius.all(Radius.circular(4)),
  );

  const AppSkeletonLoader.circle({
    Key? key,
    required double size,
  }) : this(
    key: key,
    width: size,
    height: size,
  );

  const AppSkeletonLoader.listTile({
    Key? key,
  }) : this(
    key: key,
    height: 72,
    borderRadius: const BorderRadius.all(Radius.circular(8)),
  );

  @override
  State<AppSkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<AppSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColors.surface;
    final highlightColor = AppColors.surfaceAlt;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ??
                const BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ],
            ),
          ),
        );
      },
    );
  }
}