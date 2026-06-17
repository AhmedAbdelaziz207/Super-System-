import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class ProfileSettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ProfileSettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          children: [
            trailing ?? Icon(Icons.chevron_left, color: AppColors.onSurfaceVariant, size: 22.w),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.cairo(
                color: AppColors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20.w),
            ),
          ],
        ),
      ),
    );
  }
}
