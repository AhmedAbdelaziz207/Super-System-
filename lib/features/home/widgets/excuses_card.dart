import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/routing/app_routes.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/absences_requests/model/execuse_model.dart';

class ExcusesCard extends StatelessWidget {
  final List<ExecuseRequest> requests;
  final String groupName;

  const ExcusesCard({
    super.key,
    required this.requests,
    this.groupName = '',
  });

  static const _statusColors = [AppColors.warning, AppColors.success, AppColors.primary];

  @override
  Widget build(BuildContext context) {
    final recentRequests = requests.take(2).toList();

    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.absenceRequests),
      borderRadius: BorderRadius.circular(16),
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
              children: [
                Text(
                  'سجل الاستئذان',
                  style: GoogleFonts.cairo(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12.sp,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'إدارة الاستئذانات',
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.assignment_outlined, color: AppColors.onSurfaceVariant, size: 20.w),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'آخر الطلبات',
              style: GoogleFonts.cairo(color: AppColors.onSurfaceVariant, fontSize: 12.sp),
            ),
            SizedBox(height: 12.h),
            if (recentRequests.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  'لا توجد طلبات استئذان حالياً',
                  style: GoogleFonts.cairo(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12.sp,
                  ),
                ),
              )
            else
              ...List.generate(recentRequests.length, (index) {
                final request = recentRequests[index];
                return Padding(
                  padding: EdgeInsets.only(top: index > 0 ? 12.h : 0),
                  child: _ExcuseItem(
                    reason: request.reason ?? 'بدون سبب',
                    date: _formatDate(request),
                    groupLabel: groupName,
                    statusColor: _statusColors[index % _statusColors.length],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  static String _formatDate(ExecuseRequest request) {
    if (request.absenceDates.isEmpty) {
      return request.submittedAt?.datetime ?? '';
    }
    final date = request.absenceDates.first;
    return [
      if (date.dayName != null) date.dayName!,
      if (date.monthName != null) date.monthName!,
      if (date.absenceDate != null) date.absenceDate!,
    ].join(' ');
  }
}

class _ExcuseItem extends StatelessWidget {
  final String reason;
  final String date;
  final String groupLabel;
  final Color statusColor;

  const _ExcuseItem({
    required this.reason,
    required this.date,
    required this.groupLabel,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBackgroundLight, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (groupLabel.isNotEmpty)
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  groupLabel,
                  style: GoogleFonts.cairo(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 8.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            )
          else
            const SizedBox.shrink(),
          SizedBox(width: 8.w),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    reason,
                    style: GoogleFonts.cairo(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (date.isNotEmpty)
                    Text(
                      date,
                      style: GoogleFonts.cairo(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12.sp,
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12.w),
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
