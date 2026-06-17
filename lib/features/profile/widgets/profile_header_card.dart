import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String studentName;
  final String subtitle;
  final String studentCode;
  final String generalAverage;

  const ProfileHeaderCard({
    super.key,
    required this.studentName,
    required this.subtitle,
    required this.studentCode,
    required this.generalAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.cardBackground,
            AppColors.cardBackgroundLight.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBackgroundLight.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _ProfileAvatar(),
          SizedBox(height: 16.h),
          Text(
            studentName.isNotEmpty ? studentName : 'اسم الطالب غير متاح',
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              color: AppColors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle.isNotEmpty ? subtitle : 'طالب',
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              color: AppColors.onSurfaceVariant,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _InfoBox(
                  label: 'المعدل العام',
                  value: generalAverage.isNotEmpty ? generalAverage : 'غير متوفر',
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _InfoBox(
                  label: 'رقم الهوية',
                  value: studentCode.isNotEmpty ? studentCode : 'غير متوفر',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.w,
      height: 88.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.5),
            AppColors.secondary.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 72.w,
          height: 72.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cardBackgroundLight.withValues(alpha: 0.6),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 2),
          ),
          child: Icon(Icons.person_outline, color: AppColors.white, size: 36.w),
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBackgroundLight.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              color: AppColors.onSurfaceVariant,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              color: AppColors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
