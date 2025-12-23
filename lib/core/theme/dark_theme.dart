import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.primaryHover,
    error: AppColors.error,
    background: AppColors.background,
    surface: AppColors.surface,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
  ),
  dividerColor: AppColors.divider,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
    bodySmall: TextStyle(color: AppColors.textMuted),
  ),
);
