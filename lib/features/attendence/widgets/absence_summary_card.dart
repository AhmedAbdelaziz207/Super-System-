import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class AbsenceSummaryCard extends StatelessWidget {
  final int totalAbsent;

  const AbsenceSummaryCard({super.key, required this.totalAbsent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBackgroundLight, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: icon
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.event_busy_outlined,
              color: const Color(0xFFC29CFC), // Soft purple like in design
              size: 28.w,
            ),
          ),
          // Right side: summary info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'إجمالي عدد أيام الغياب',
                style: GoogleFonts.cairo(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${totalAbsent.toString().padLeft(2, '0')} ',
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'يوم',
                      style: GoogleFonts.cairo(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
