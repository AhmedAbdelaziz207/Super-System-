import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/exams/model/exams_results_model.dart';

class ExamsHeader extends StatelessWidget {
  final StudentModel student;

  const ExamsHeader({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLight.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBackgroundLight.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'لوحة النتائج',
            style: GoogleFonts.cairo(
              color: AppColors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            student.academicYearArabic!,
            style: GoogleFonts.cairo(
              color: AppColors.onSurfaceVariant,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            student.groupName!,
            style: GoogleFonts.cairo(
              color: AppColors.onSurfaceVariant,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
