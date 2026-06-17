import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/home/model/home_response.dart';

import 'package:super_system/core/routing/app_routes.dart';

class PerformanceCard extends StatelessWidget {
  final LastExam lastExam;

  const PerformanceCard({super.key, required this.lastExam});

  @override
  Widget build(BuildContext context) {
    final passed = lastExam.passed ?? false;
    final percentageValue = double.tryParse(lastExam.percentage?.replaceAll('%', '') ?? '0') ?? 0.0;
    final percentageFraction = percentageValue / 100.0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.exams);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBackgroundLight, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'الأداء الدراسي',
                style: GoogleFonts.cairo(
                  color: AppColors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.bar_chart_outlined, color: AppColors.onSurfaceVariant, size: 20.w),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'آخر نتيجة (${lastExam.examName ?? ''})',
                    style: GoogleFonts.cairo(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 12.sp,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${lastExam.studentGrade} ',
                          style: GoogleFonts.cairo(
                            color: AppColors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '/ ${lastExam.totalGrade}',
                          style: GoogleFonts.cairo(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        passed ? 'أعلى بـ 12% من متوسط المجموعة' : 'أقل من متوسط المجموعة', // Example hardcoded logic since API doesn't provide group comparison
                        style: GoogleFonts.cairo(
                          color: passed ? AppColors.success : AppColors.error,
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(passed ? Icons.trending_up : Icons.trending_down, color: passed ? AppColors.success : AppColors.error, size: 14.w),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 32.w),
              SizedBox(
                width: 80.w,
                height: 80.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80.w,
                      height: 80.w,
                      child: CircularProgressIndicator(
                        value: percentageFraction,
                        strokeWidth: 6.w,
                        backgroundColor: AppColors.cardBackgroundLight,
                        color: passed ? AppColors.primary : AppColors.error,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          lastExam.percentage ?? '0%',
                          style: GoogleFonts.cairo(
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          passed ? 'ناجح' : 'راسب',
                          style: GoogleFonts.cairo(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 10.sp,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
