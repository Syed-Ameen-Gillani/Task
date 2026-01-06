import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primaryGreen = Color(0xFF20B76F);
  static const Color primaryGreenLight = Color(0x3020B76F); // 30% opacity

  // Gradient Colors (for border-image-source)
  static const Color gradientBlueStart = Color(0xFF7BBDE2);
  static const Color gradientTealMiddle = Color(0xFF69C0B1);
  static const Color gradientGreenEnd = Color(0xFF60C198);

  // Gradient Definition
  static const LinearGradient borderGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.0, 0.6645, 1.0],
    colors: [gradientBlueStart, gradientTealMiddle, gradientGreenEnd],
  );

  // Accent & UI Colors
  static const Color accentBlue = Color(0xFF48A4E5);
  static const Color darkNavy = Color(0xFF1B3D45);
  static const Color tealAccent = Color(0xFF32AAB7);
  static const Color accentPurple = Color(0xFF4855DF);
  static const Color textSecondary = Color(0xFF5D607C);
  static const Color textTertiary = Color(0xFF7A7C90);
  static const Color successGreen = Color(0xFF18AA99);
  static const Color backgroundLight = Color(0xFFEBEBEB);
  static const Color cardBackgroundDark = Color(0xFF18181C);

  // Semantic Color Aliases (for better context)
  static const Color success = successGreen;
  static const Color primary = primaryGreen;
  static const Color background = backgroundLight;
  static const Color textDark = darkNavy;
  static const Color textMedium = textSecondary;
  static const Color textLight = textTertiary;
  static const Color textGray =
      backgroundLight; // #EBEBEB - for light gray text
  static const Color textMuted = Color(0xFFA4A4A4); // #A4A4A4
}
