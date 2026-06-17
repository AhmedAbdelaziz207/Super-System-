import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/notifications/models/notifications_model.dart';

class NotificationItemCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItemCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
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
                color: Colors.green,
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.w, 20.w, 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon on the right (RTL context, first child)
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:Colors.green.withValues(alpha: 0.2),
                    ),
                    child: Icon(
                      notification.icon,
                      color: Colors.green,
                      size: 20.w,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Content details in the middle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: GoogleFonts.cairo(
                            color: AppColors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          notification.body,
                          style: GoogleFonts.cairo(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        if (notification.extraData != null) ...[
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: notification.color.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: notification.color.withValues(alpha: 0.5)),
                            ),
                            child: Text(
                              notification.extraData!,
                              style: GoogleFonts.cairo(
                                color: notification.color,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Time ago on the left (RTL context, last child)
                  Text(
                    notification.timeAgo,
                    style: GoogleFonts.cairo(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 10.sp,
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
