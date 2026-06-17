import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class AbsenceRequestSummaryRow extends StatelessWidget {
  final int totalRequests;
  final int totalExcusedDays;

  const AbsenceRequestSummaryRow({
    super.key,
    required this.totalRequests,
    required this.totalExcusedDays,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'أيام الاستئذان',
            value: totalExcusedDays,
            accentColor: AppColors.onSurfaceVariant,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _SummaryCard(
            label: 'إجمالي الطلبات',
            value: totalRequests,
            accentColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final int value;
  final Color accentColor;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBackgroundLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              color: AppColors.onSurfaceVariant,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value.toString(),
            style: GoogleFonts.cairo(
              color: AppColors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value > 0 ? 1.0 : 0.0,
              minHeight: 4.h,
              backgroundColor: AppColors.surfaceBright,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
