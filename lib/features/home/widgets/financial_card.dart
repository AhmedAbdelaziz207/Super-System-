import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/home/model/home_response.dart';

import 'package:super_system/core/routing/app_routes.dart';

class FinancialCard extends StatelessWidget {
  final FinancialStatus financialStatus;
  final String groupName;

  const FinancialCard({
    super.key,
    required this.financialStatus,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.finance);
      },
      child: Container(
        width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBackgroundLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  groupName.isNotEmpty ? groupName : 'غير محدد',
                  style: GoogleFonts.cairo(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'المستحقات المالية',
                        style: GoogleFonts.cairo(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    financialStatus.message ?? 'بيانات الشهر الحالي',
                    style: GoogleFonts.cairo(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBackgroundLight, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
                  ),
                  child: Icon(Icons.account_balance_wallet_outlined, color: AppColors.onSurfaceVariant, size: 24.w),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      financialStatus.isPaid == true ? 'تم الدفع' : 'الرصيد المتبقي',
                      style: GoogleFonts.cairo(
                        color: financialStatus.isPaid == true ? AppColors.success : AppColors.onSurfaceVariant,
                        fontSize: 12.sp,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${financialStatus.expectedAmount ?? 0} ',
                            style: GoogleFonts.cairo(
                              color: AppColors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'جنية',
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
          ),
        ],
      ),
    ),
  );
}
}
