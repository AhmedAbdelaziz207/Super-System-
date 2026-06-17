import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          ' مرحبًا بك في Super System',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            shadows: [
              Shadow(
                color: AppColors.primary.withOpacity(0.6),
                blurRadius: 6,
              ),
            ],
          )),
        const SizedBox(height: 8),
        Text(
          'نضمن لك متابعة لائقة',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 13.sp,
            color: AppColors.white,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
