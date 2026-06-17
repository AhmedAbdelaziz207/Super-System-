import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: GoogleFonts.cairo(
        color: AppColors.white,
        fontSize: 14,
      ),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.onSurfaceVariant,
          fontSize: 14,
        ),
        prefixIcon: Icon(prefixIcon, color: AppColors.onSurfaceVariant, size: 20.r),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surface.withOpacity(0.4),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.outlineVariant, width: 1.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5.r),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.redAccent, width: 1.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.redAccent, width: 1.5.r),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
      ),
    );
  }
}
