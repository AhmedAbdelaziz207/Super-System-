import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/di/dependency_injection.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/widgets/fade_in_up.dart';
import 'package:super_system/features/notifications/logic/notifications_cubit.dart';
import 'package:super_system/features/notifications/logic/notifications_states.dart';
import 'package:super_system/features/notifications/models/notifications_model.dart';
import 'package:super_system/features/notifications/widgets/notification_header.dart';
import 'package:super_system/features/notifications/widgets/notification_item_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationsCubit>()..getNotifications(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w, bottom: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 20.w),
                        ),
                      ),
                      const NotificationHeader(),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<NotificationsCubit, NotificationsStates>(
                    builder: (context, state) {
                      if (state is NotificationsLoading || state is NotificationsInitial) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is NotificationsFailure) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: AppColors.error),
                          ),
                        );
                      } else if (state is NotificationsSuccess) {
                        final notifications = state.data.notifications;
                            int delayIndex = 0;
                        Duration getDelay() =>
                            Duration(milliseconds: 100 + delayIndex++);
                        if (notifications.isEmpty) {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                            itemCount: dummyNotifications.length,
                            separatorBuilder: (context, index) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              return FadeInUp(
                                delay: getDelay(),
                                child: NotificationItemCard(notification: dummyNotifications[index]),
                              );
                            },
                          );
                          // return Center(
                          //   child: Text(
                          //     'لا توجد تنبيهات حالياً',
                          //     style: GoogleFonts.cairo(
                          //       color: AppColors.onSurfaceVariant,
                          //       fontSize: 16.sp,
                          //     ),
                          //   ),
                          // );
                        }

                        // int delayIndex = 0;
                        // Duration getDelay() => Duration(milliseconds: 100 + delayIndex++);

                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                          itemCount: notifications.length,
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            return FadeInUp(
                              delay: getDelay(),
                              child: NotificationItemCard(notification: notifications[index]),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: BlocBuilder<NotificationsCubit, NotificationsStates>(
                    builder: (context, state) {
                      if (state is NotificationsSuccess && state.data.notifications.isNotEmpty) {
                        return FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: Text(
                            'جميع التنبيهات محملة، استمتع بيومك!',
                            style: GoogleFonts.cairo(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 12.sp,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final dummyNotifications = [
  NotificationModel(
    createdAt: DateTime.now().toString(),
    title: 'تنبيه تجريبي',
    body: 'هذا تنبيه تجريبي',
  ),
  NotificationModel(
    createdAt: DateTime.now().toString(),
    title: 'تنبيه تجريبي',
    body: 'هذا تنبيه تجريبي',
  ),
  NotificationModel(
    createdAt: DateTime.now().toString(),
    title: 'تنبيه تجريبي',
    body: 'هذا تنبيه تجريبي',
  ),
  NotificationModel(
    createdAt: DateTime.now().toString(),
    title: 'تنبيه تجريبي',
    body: 'هذا تنبيه تجريبي',
  ),
  NotificationModel(
    createdAt: DateTime.now().toString(),
    title: 'تنبيه تجريبي',
    body: 'هذا تنبيه تجريبي',
  ),
  NotificationModel(
    createdAt: DateTime.now().toString(),
    title: 'تنبيه تجريبي',
    body: 'هذا تنبيه تجريبي',
  ),
  NotificationModel(
    createdAt: DateTime.now().toString(),
    title: 'تنبيه تجريبي',
    body: 'هذا تنبيه تجريبي',
  ),
  NotificationModel(
    createdAt: DateTime.now().toString(),
    title: 'تنبيه تجريبي',
    body: 'هذا تنبيه تجريبي',
  ),
  NotificationModel(
    createdAt: DateTime.now().toString(),
    title: 'تنبيه تجريبي',
    body: 'هذا تنبيه تجريبي',
  ),
];
