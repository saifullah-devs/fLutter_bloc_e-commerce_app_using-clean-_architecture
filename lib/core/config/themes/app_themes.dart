import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../color/colors.dart';

class AppTheme {
  AppTheme._();

  // =========================================================
  // LIGHT THEME
  // =========================================================
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        brightness: Brightness.light,
      ),
      // Pass Colors.black for all text in Light Mode
      textTheme: _buildTextTheme(base.textTheme, Colors.black),
      appBarTheme: _headTheme,
      inputDecorationTheme: _inputTheme(
        textColor: Colors.grey,
        fillColor: Colors.white,
      ),
      elevatedButtonTheme: _buttonTheme,
    );
  }

  // =========================================================
  // DARK THEME
  // =========================================================
  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        surface: Color(0xFF121212),
      ),
      textTheme: _buildTextTheme(base.textTheme, Colors.white),
      appBarTheme: _headTheme,
      inputDecorationTheme: _inputTheme(
        textColor: Colors.white,
        fillColor: AppColors.backgroundColor,
      ),
      elevatedButtonTheme: _buttonTheme,
    );
  }

  // =========================================================
  // TEXT THEME BUILDER (ALL 15 STYLES)
  // =========================================================
  static TextTheme _buildTextTheme(TextTheme baseTextTheme, Color textColor) {
    return GoogleFonts.poppinsTextTheme(baseTextTheme).copyWith(
      // -- Display --
      displayLarge: GoogleFonts.poppins(
        color: textColor,
        fontSize: 57,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.poppins(
        color: textColor,
        fontSize: 45,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.poppins(
        color: textColor,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),

      // -- Headline --
      headlineLarge: GoogleFonts.poppins(
        color: textColor,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.poppins(
        color: textColor,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.poppins(
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),

      // -- Title --
      titleLarge: GoogleFonts.poppins(
        color: textColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: GoogleFonts.poppins(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.poppins(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),

      // -- Body --
      bodyLarge: GoogleFonts.poppins(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: GoogleFonts.poppins(
        color: textColor,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),

      // -- Label --
      labelLarge: GoogleFonts.poppins(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.poppins(
        color: textColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.poppins(
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // =========================================================
  // SUB-THEMES
  // =========================================================
  static final AppBarTheme _headTheme = AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
      color: Colors.white,
    ),
  );

  static InputDecorationTheme _inputTheme({
    required Color textColor,
    required Color fillColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: TextStyle(color: textColor),
      hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  static final ElevatedButtonThemeData _buttonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}
