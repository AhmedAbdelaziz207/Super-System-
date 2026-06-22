import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/home/model/home_response.dart';

import 'package:super_system/core/routing/app_routes.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceStats attendanceStats;

  const AttendanceCard({super.key, required this.attendanceStats});

  @override
  Widget build(BuildContext context) {
    final commitmentValue =
        double.tryParse(
          attendanceStats.commitmentRate?.replaceAll('%', '') ?? '0',
        ) ??
        0.0;
    final commitmentFraction = commitmentValue / 100.0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.attendence);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant, width: 1),
            ),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عرض السجل الكامل',
                  style: GoogleFonts.cairo(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 8.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'سجل الحضور والانضباط',
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.onSurfaceVariant,
                      size: 20.w,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                _buildStatBox(
                  'إذن',
                  attendanceStats.excusedDays?.toString().padLeft(2, '0') ??
                      '00',
                  AppColors.warning,
                ),
                SizedBox(width: 12.w),
                _buildStatBox(
                  'غياب',
                  attendanceStats.absentDays?.toString().padLeft(2, '0') ??
                      '00',
                  AppColors.error,
                ),
                SizedBox(width: 12.w),
                _buildStatBox(
                  'حضور',
                  attendanceStats.attendedDays?.toString().padLeft(2, '0') ??
                      '00',
                  AppColors.success,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${attendanceStats.lastAttendance?.date ?? ''}, ${attendanceStats.lastAttendance?.time ?? ''}',
                  style: GoogleFonts.cairo(
                    color: AppColors.success,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'آخر حالة حضور:',
                  style: GoogleFonts.cairo(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: commitmentFraction,
                backgroundColor: AppColors.cardBackgroundLight,
                color: AppColors.white,
                minHeight: 6.h,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'معدل الالتزام: ${attendanceStats.commitmentRate ?? "N/A"}',
                  style: GoogleFonts.cairo(
                    color: AppColors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              '* التواريخ المستثناة مستبعدة من سجل الغياب',
              style: GoogleFonts.cairo(
                color: AppColors.onSurfaceVariant,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
      ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBackgroundLight, width: 1),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.cairo(
                color: color,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.cairo(
                color: AppColors.onSurfaceVariant,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
