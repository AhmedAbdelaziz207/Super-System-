import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'ابق على اطلاع',
          style: GoogleFonts.cairo(
            color: AppColors.error,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.warning, AppColors.error],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: Text(
            'التنبيهات',
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
