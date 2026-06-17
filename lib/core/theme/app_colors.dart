
import 'package:flutter/material.dart';

sealed class AppColors {

  // Brand & Primary Colors
  static const Color primary = Color(0xFFBC13FE);
  static const Color secondary = Color(0xFF8F00FF);

  // Surface & Backgrounds
  static const Color surface = Color(0xFF0a0b1e);
  static const Color surfaceDim = Color(0xFF19101C);
  static const Color surfaceBright = Color(0xFF403643);
  static const Color surfaceContainerLowest = Color(0xFF130B16);
  static const Color surfaceContainerLow = Color(0xFF211824);

  // Overlays & Outlines
  static const Color outlineVariant = Color(0x4DFFFFFF); // 30% Opacity
  static const Color onSurfaceVariant = Color(0xB3FFFFFF); // 70% Opacity
  static const Color white = Color(0xFFFFFFFF);

  // Semantic & UI Colors
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFFC107); // Yellow
  static const Color error = Color(0xFFE53935); // Red
  static const Color cardBackground = Color(0xFF230541); // Deep Purple Card
  static const Color cardBackgroundLight = Color(0xFF3B1B5A); // Lighter Card
}