
import 'package:flutter/material.dart';

sealed class AppColors {

  // Brand & Primary Colors
  static const Color primary = Color(0xFF00E5FF); // Neon Cyan Accent
  static const Color secondary = Color(0xFF00B8D4);

  // Surface & Backgrounds (Monochromatic Dark)
  static const Color surface = Color(0xFF0A0A0A); // Very deep black/gray
  static const Color surfaceDim = Color(0xFF050505);
  static const Color surfaceBright = Color(0xFF1F1F1F);
  static const Color surfaceContainerLowest = Color(0xFF000000);
  static const Color surfaceContainerLow = Color(0xFF141414);

  // Overlays & Outlines
  static const Color outlineVariant = Color(0x33FFFFFF); // 20% Opacity
  static const Color onSurfaceVariant = Color(0xB3FFFFFF); // 70% Opacity
  static const Color white = Color(0xFFFFFFFF);

  // Semantic & UI Colors
  static const Color success = Color(0xFF00E676); // Neon Green
  static const Color warning = Color(0xFFFFD600); // Neon Yellow
  static const Color error = Color(0xFFFF1744); // Neon Red
  
  // Glassmorphism Card Backgrounds (Semi-transparent)
  static const Color cardBackground = Color(0x1AFFFFFF); // 10% White for glass
  static const Color cardBackgroundLight = Color(0x26FFFFFF); // 15% White for glass
}