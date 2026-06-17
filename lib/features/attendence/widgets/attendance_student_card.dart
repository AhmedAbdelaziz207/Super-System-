import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/attendence/model/attendence_model.dart';

class AttendanceStudentCard extends StatelessWidget {
  final Student student;

  const AttendanceStudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              student.studentCode,
              style: GoogleFonts.cairo(
                color: AppColors.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              'كود الطالب:',
              style: GoogleFonts.cairo(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          '${_getAcademicYearArabic(student.academicYear)} - ${student.groupName}',
          style: GoogleFonts.cairo(
            color: AppColors.onSurfaceVariant,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }

  String _getAcademicYearArabic(String academicYear) {
    switch (academicYear) {
      case 'third_secondary':
        return 'الصف الثالث الثانوي';
      case 'second_secondary':
        return 'الصف الثاني الثانوي';
      case 'first_secondary':
        return 'الصف الأول الثانوي';
      default:
        return academicYear;
    }
  }
}
