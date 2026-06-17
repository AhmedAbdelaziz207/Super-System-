import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/routing/app_routes.dart';
import 'package:super_system/core/theme/app_colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String studentName;
  final VoidCallback? onProfileTap;

  const HomeAppBar({super.key, required this.studentName, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 24.w,
        right: 24.w,
        bottom: 10.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.notifications);
              },
              child: Icon(
                Icons.notifications_none_outlined,
                color: AppColors.primary,
                size: 26.w,
              ),
            ),
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('👋', style: TextStyle(fontSize: 18.sp)),
                  SizedBox(width: 8.w),
                  Text(
                    studentName.isNotEmpty
                        ? 'أهلاً بولي أمر $studentName'
                        : 'أهلاً بولي الأمر',
                    style: GoogleFonts.cairo(
                      color: AppColors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'مساء الخير, استعرض ملخص اليوم',
                style: GoogleFonts.cairo(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 8.sp,
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          InkWell(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.menu, color: AppColors.white, size: 16.w),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
