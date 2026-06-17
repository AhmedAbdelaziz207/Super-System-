import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/exams/model/exams_results_model.dart';

class ExamItemCard extends StatelessWidget {
  final ExamModel exam;

  const ExamItemCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final bool attended = exam.studentResult?.attended ?? false;
    final int percent =
        double.tryParse(
          exam.studentResult?.percentage?.replaceAll('%', '') ?? '0',
        )?.toInt() ??
        0;

    // Choose icon based on keywords
    IconData getExamIcon() {
      final name = exam.examName?.toLowerCase() ?? '';
      if (name.contains('كيمياء') || name.contains('chem')) {
        return Icons.science_outlined;
      } else if (name.contains('فيزياء') || name.contains('phys')) {
        return Icons.functions_outlined;
      } else if (name.contains('رياض') || name.contains('math')) {
        return Icons.calculate_outlined;
      } else if (name.contains('أحياء') || name.contains('bio')) {
        return Icons.biotech_outlined;
      }
      return Icons.assignment_outlined;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLight.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Top Info Row (Icon, Title, Date, status pill if absent)
          Row(
            children: [
              if (!attended) ...[
                // Absent badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'غائب',
                    style: GoogleFonts.cairo(
                      color: AppColors.error,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
              ] else ...[
                const Spacer(),
              ],

              // Exam Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    exam.examName!,
                    style: GoogleFonts.cairo(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _formatDate(exam.createdAt!),
                    style: GoogleFonts.cairo(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),

              // Exam Icon
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  getExamIcon(),
                  color: const Color(0xFFC29CFC), // Accent purple
                  size: 22.w,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Middle Section (Differs based on Attended/Absent)
          if (attended) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Circular Progress
                SizedBox(
                  width: 54.w,
                  height: 54.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: percent / 100.0,
                        backgroundColor: AppColors.cardBackgroundLight
                            .withValues(alpha: 0.5),
                        color: const Color(0xFFC29CFC),
                        strokeWidth: 4.w,
                      ),
                      Text(
                        '$percent%',
                        style: GoogleFonts.cairo(
                          color: AppColors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Grades Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'الدرجة',
                          style: GoogleFonts.cairo(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${exam.studentResult?.grade}',
                          style: GoogleFonts.cairo(
                            color: AppColors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' / ${exam.totalGrade}',
                          style: GoogleFonts.cairo(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Status Badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'الحالة',
                      style: GoogleFonts.cairo(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        exam.studentResult?.passStatus ?? 'ناجح',
                        style: GoogleFonts.cairo(
                          color: AppColors.success,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Divider
            Divider(
              color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
              height: 1,
            ),
            SizedBox(height: 8.h),

            // Cohort Stats (Bottom bar)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'نسبة النجاح: ${exam.examStats?.successRate ?? ""}',
                  style: GoogleFonts.cairo(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 1.w,
                  height: 10.h,
                  color: AppColors.cardBackgroundLight,
                ),
                SizedBox(width: 8.w),
                Text(
                  'عدد المتقدمين: ${exam.examStats?.totalSat ?? 0}',
                  style: GoogleFonts.cairo(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.people_outline,
                  color: AppColors.onSurfaceVariant,
                  size: 14.w,
                ),
              ],
            ),
          ] else ...[
            // Absent Content
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Action Link
                  InkWell(
                    onTap: () {
                      // Submit excuse action
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: const Color(0xFFC29CFC),
                          size: 14.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'تقديم عذر',
                          style: GoogleFonts.cairo(
                            color: const Color(0xFFC29CFC),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Text Warning
                  Text(
                    'لم يتم رصد درجة لعدم الحضور',
                    style: GoogleFonts.cairo(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    // Basic date parsing to show e.g. "28 أبريل 2026"
    try {
      final parts = dateStr.split(' ')[0].split('-');
      if (parts.length == 3) {
        final year = parts[0];
        final monthVal = int.tryParse(parts[1]) ?? 1;
        final day = parts[2];
        const monthNames = [
          'يناير',
          'فبراير',
          'مارس',
          'أبريل',
          'مايو',
          'يونيو',
          'يوليو',
          'أغسطس',
          'سبتمبر',
          'أكتوبر',
          'نوفمبر',
          'ديسمبر',
        ];
        return '$day ${monthNames[monthVal - 1]} $year';
      }
    } catch (_) {}
    return dateStr;
  }
}
