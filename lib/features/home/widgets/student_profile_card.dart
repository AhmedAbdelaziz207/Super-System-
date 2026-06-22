import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/routing/app_routes.dart';
import 'package:super_system/core/theme/app_colors.dart';

class StudentProfileCard extends StatelessWidget {
  final String studentName;
  final String studentCode;
  final String parentPhone;
  final String groupName;
  final String? generalAverage;

  const StudentProfileCard({
    super.key,
    required this.studentName,
    required this.studentCode,
    required this.parentPhone,
    required this.groupName,
    this.generalAverage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.pushNamed(
            context,
            AppRoutes.profile,
            arguments: generalAverage,
          ),
      borderRadius: BorderRadius.circular(16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        AppRoutes.profile,
                        arguments: generalAverage,
                      ),
                  borderRadius: BorderRadius.circular(8),
                  child: Icon(
                    Icons.edit,
                    color: AppColors.onSurfaceVariant,
                    size: 20.w,
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      studentName.isNotEmpty
                          ? studentName
                          : 'اسم الطالب غير متاح',
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackgroundLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        groupName.isNotEmpty ? groupName : 'غير محدد',
                        style: GoogleFonts.cairo(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    color: AppColors.onSurfaceVariant,
                    size: 28.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رقم ولي الأمر',
                      style: GoogleFonts.cairo(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      parentPhone.isNotEmpty ? parentPhone : 'غير متوفر',
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'كود الطالب',
                      style: GoogleFonts.cairo(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      studentCode.isNotEmpty ? studentCode : 'N/A',
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      ),
      ),
    );
  }
}
