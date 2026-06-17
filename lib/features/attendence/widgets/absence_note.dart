import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class AbsenceNote extends StatelessWidget {
  final String note;

  const AbsenceNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            note,
            style: GoogleFonts.cairo(
              color: AppColors.onSurfaceVariant,
              fontSize: 10.sp,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(width: 6.w),
        Icon(
          Icons.info_outline,
          color: AppColors.onSurfaceVariant,
          size: 14.w,
        ),
      ],
    );
  }
}
