import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/attendence/model/attendence_model.dart';

class AbsenceRecordCard extends StatelessWidget {
  final AbsenceRecord record;

  const AbsenceRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    const accentColor = AppColors.error; // Red for absent

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBackgroundLight, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Side colored bar
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 4.w,
                color: accentColor,
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.w, 20.w, 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side: status pill
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      'غائب',
                      style: GoogleFonts.cairo(
                        color: accentColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Right side: details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Date Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${record.absenceDate} (${record.dayName})',
                              style: GoogleFonts.cairo(
                                color: AppColors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: AppColors.onSurfaceVariant,
                              size: 14.w,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        // Time Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${record.sessionStart} - ${record.sessionEnd}',
                              style: GoogleFonts.cairo(
                                color: AppColors.onSurfaceVariant,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.access_time,
                              color: AppColors.onSurfaceVariant,
                              size: 14.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
