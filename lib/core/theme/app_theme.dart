import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.secondary,
  );
}