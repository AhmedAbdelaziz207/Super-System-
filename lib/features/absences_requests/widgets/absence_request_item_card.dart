import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/absences_requests/model/execuse_model.dart';

class AbsenceRequestItemCard extends StatelessWidget {
  final ExecuseRequest request;

  const AbsenceRequestItemCard({super.key, required this.request});

  String get _dateLabel {
    if (request.absenceDates.isEmpty) return '';
    final date = request.absenceDates.first;
    final parts = <String>[
      if (date.dayName != null) date.dayName!,
      if (date.monthName != null) date.monthName!,
      if (date.absenceDate != null) date.absenceDate!,
    ];
    return parts.join(' ');
  }

  String get _daysLabel {
    final count = request.totalAbsenceDates ?? request.absenceDates.length;
    if (count == 0) return '';
    return '$count ${count == 1 ? 'يوم' : 'أيام'}';
  }

  String get _submitterLabel {
    if (request.submittedBy?.assistantName != null) {
      return 'بواسطة ${request.submittedBy!.assistantName} (مساعد)';
    }
    if (request.requestedBy == 'parent') return 'بواسطة ولي الأمر';
    return 'بواسطة ${request.requestedBy ?? 'غير محدد'}';
  }

  String get _timeAgoLabel => _formatTimeAgo(request.submittedAt?.datetime);

  static String _formatTimeAgo(String? datetime) {
    if (datetime == null || datetime.isEmpty) return '';
    try {
      final normalized = datetime.contains('T') ? datetime : datetime.replaceFirst(' ', 'T');
      final dt = DateTime.parse(normalized);
      final diff = DateTime.now().difference(dt);
      if (diff.inDays > 0) return 'منذ ${diff.inDays} ${diff.inDays == 1 ? 'يوم' : 'أيام'}';
      if (diff.inHours > 0) return 'منذ ${diff.inHours} ${diff.inHours == 1 ? 'ساعة' : 'ساعات'}';
      if (diff.inMinutes > 0) return 'منذ ${diff.inMinutes} دقيقة';
      return 'الآن';
    } catch (_) {
      return datetime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLight.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBackgroundLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (request.requestCode != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                request.requestCode!,
                style: GoogleFonts.cairo(
                  color: AppColors.primary.withValues(alpha: 0.8),
                  fontSize: 11.sp,
                ),
              ),
            ),
          if (request.requestCode != null) SizedBox(height: 8.h),
          Text(
            request.reason ?? 'بدون سبب',
            style: GoogleFonts.cairo(
              color: AppColors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 12.h),
          if (_dateLabel.isNotEmpty)
            _DetailRow(icon: Icons.calendar_today_outlined, text: _dateLabel),
          if (_daysLabel.isNotEmpty) ...[
            SizedBox(height: 6.h),
            _DetailRow(icon: Icons.schedule_outlined, text: _daysLabel),
          ],
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.15),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
                ),
                child: Icon(Icons.person_outline, color: AppColors.primary, size: 22.w),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _submitterLabel,
                      style: GoogleFonts.cairo(
                        color: AppColors.primary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    if (_timeAgoLabel.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        _timeAgoLabel,
                        style: GoogleFonts.cairo(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
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

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: GoogleFonts.cairo(color: AppColors.onSurfaceVariant, fontSize: 12.sp),
        ),
        SizedBox(width: 6.w),
        Icon(icon, color: AppColors.onSurfaceVariant, size: 16.w),
      ],
    );
  }
}
