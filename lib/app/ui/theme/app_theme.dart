import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // New "Galactic Cobalt" Palette
  static const Color background = Color(0xFF17181C);
  static const Color surface = Color(0xFF1F2025);
  static const Color accentPanel = Color(0xFF292B31);
  static const Color primary = Color(0xFF4A72FF);
  static const Color textPrimary = Color(0xFFF0F1F5);
  static const Color textSecondary = Color(0xFF7A7F8B);
}

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.surface, // Changed to surface
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary, // Use primary for secondary as well
      surface: AppColors.surface,
      background: AppColors.background,
      onPrimary: Colors.white,
      onSecondary: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
      onBackground: AppColors.textPrimary,
    ),
    textTheme: GoogleFonts.interTextTheme( // Switched to Inter for a modern, clean look
      const TextTheme(
        bodyMedium: TextStyle(color: AppColors.textPrimary, height: 1.5),
        headlineSmall: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(color: AppColors.textSecondary),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 22),
    dividerColor: AppColors.accentPanel,
     // Custom additions for our design
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.background,
      hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.7)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
  );
}