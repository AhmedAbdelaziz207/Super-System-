import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class ProfileGuardianCard extends StatelessWidget {
  final String guardianName;
  final String guardianRelation;
  final String parentPhone;
  final VoidCallback? onCall;

  const ProfileGuardianCard({
    super.key,
    required this.guardianName,
    required this.guardianRelation,
    required this.parentPhone,
    this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.cardBackground,
            AppColors.cardBackgroundLight.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'معلومات ولي الأمر',
                style: GoogleFonts.cairo(
                  color: AppColors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.family_restroom_outlined,
                color: AppColors.primary,
                size: 22.w,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              if (parentPhone.isNotEmpty)
                InkWell(
                  onTap: onCall,
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.2),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Icon(
                      Icons.phone_outlined,
                      color: AppColors.primary,
                      size: 12.w,
                    ),
                  ),
                ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        guardianName.isNotEmpty ? guardianName : 'غير متوفر',
                        style: GoogleFonts.cairo(
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "رقم ولي الأمر",
                        style: GoogleFonts.cairo(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 13.sp,
                        ),
                      ),
                      if (parentPhone.isNotEmpty) ...[
                        SizedBox(height: 6.h),

                        Text(
                          parentPhone,
                          style: GoogleFonts.cairo(
                            color: AppColors.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cardBackgroundLight.withValues(
                        alpha: 0.5,
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: AppColors.onSurfaceVariant,
                      size: 24.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
