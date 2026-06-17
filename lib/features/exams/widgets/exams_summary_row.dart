import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/exams/model/exams_results_model.dart';

class ExamsSummaryRow extends StatelessWidget {
  final SummaryModel summary;

  const ExamsSummaryRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSummaryCard(
          icon: Icons.cancel_outlined,
          iconColor: AppColors.error,
          value: summary.totalAbsent.toString(),
          label: 'غياب',
        ),
        SizedBox(width: 12.w),
        _buildSummaryCard(
          icon: Icons.check_circle_outline_outlined,
          iconColor: AppColors.success,
          value: summary.totalAttended.toString(),
          label: 'حضور',
        ),
        SizedBox(width: 12.w),
        _buildSummaryCard(
          icon: Icons.assignment_outlined,
          iconColor: const Color(0xFFC29CFC), // Soft purple/lavender
          value: summary.totalExams.toString(),
          label: 'إجمالي الاختبارات',
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundLight.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBackgroundLight.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 22.w),
            SizedBox(height: 8.h),
            Text(
              value,
              style: GoogleFonts.cairo(
                color: AppColors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.cairo(
                color: AppColors.onSurfaceVariant,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
