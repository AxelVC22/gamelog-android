import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final globalLoadingProvider = StateProvider<bool>((ref) => false);

class GlobalLoader extends ConsumerWidget {
  const GlobalLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(globalLoadingProvider);

    if (!isLoading) return const SizedBox.shrink();

    return Positioned.fill(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            boxShadow: [
              BoxShadow(
                blurRadius: 24,
              ),
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),


            ],
          ),
        ),
      ),
    );
  }
}