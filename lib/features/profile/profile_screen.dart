import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/routing/app_routes.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/widgets/fade_in_up.dart';
import 'package:super_system/features/profile/logic/profile_cubit.dart';
import 'package:super_system/features/profile/logic/profile_states.dart';
import 'package:super_system/features/profile/widgets/profile_guardian_card.dart';
import 'package:super_system/features/profile/widgets/profile_header_card.dart';
import 'package:super_system/features/profile/widgets/profile_logout_button.dart';
import 'package:super_system/features/profile/widgets/profile_settings_card.dart';

class ProfileScreen extends StatefulWidget {
  final String? generalAverage;
  final bool showBackButton;

  const ProfileScreen({super.key, this.generalAverage, this.showBackButton = true});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggingOut = false;

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'قريباً',
          style: GoogleFonts.cairo(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.cardBackgroundLight,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _callGuardian(BuildContext context, String phone) {
    Clipboard.setData(ClipboardData(text: phone));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم نسخ رقم ولي الأمر: $phone',
          style: GoogleFonts.cairo(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.cardBackgroundLight,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'تسجيل الخروج',
            style: GoogleFonts.cairo(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
            style: GoogleFonts.cairo(color: AppColors.onSurfaceVariant),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('إلغاء', style: GoogleFonts.cairo(color: AppColors.onSurfaceVariant)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text('تسجيل الخروج', style: GoogleFonts.cairo(color: AppColors.error)),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true && context.mounted) {
      setState(() => _isLoggingOut = true);
      await context.read<ProfileCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(generalAverage: widget.generalAverage),
      child: BlocListener<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileLoggedOut) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.surface,
          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w, bottom: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.showBackButton)
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
                          )
                        else
                          SizedBox(width: 40.w),
                        Text(
                          'الملف الشخصي',
                          style: GoogleFonts.cairo(
                            color: AppColors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 40.w),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<ProfileCubit, ProfileStates>(
                      builder: (context, state) {
                        if (state is! ProfileLoaded) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final data = state.data;
                        int delayIndex = 0;
                        Duration getDelay() => Duration(milliseconds: 100 * delayIndex++);

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                          child: Column(
                            children: [
                              FadeInUp(
                                delay: getDelay(),
                                child: ProfileHeaderCard(
                                  studentName: data.studentName,
                                  subtitle: data.subtitle,
                                  studentCode: data.studentCode,
                                  generalAverage: data.generalAverage,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              FadeInUp(
                                delay: getDelay(),
                                child: ProfileGuardianCard(
                                  guardianName: data.guardianName,
                                  guardianRelation: data.guardianRelation,
                                  parentPhone: data.parentPhone,
                                  onCall: data.parentPhone.isNotEmpty
                                      ? () => _callGuardian(context, data.parentPhone)
                                      : null,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              FadeInUp(
                                delay: getDelay(),
                                child: ProfileSettingsCard(
                                  onAppSettings: () => _showComingSoon(context),
                                  onNotificationsChanged: (enabled) {
                                    ScaffoldMessenger.of(context).clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          enabled ? 'تم تفعيل الإشعارات' : 'تم إيقاف الإشعارات',
                                          style: GoogleFonts.cairo(color: AppColors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                        backgroundColor: AppColors.cardBackgroundLight,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  onPrivacy: () => _showComingSoon(context),
                                ),
                              ),
                              SizedBox(height: 24.h),
                              FadeInUp(
                                delay: getDelay(),
                                child: ProfileLogoutButton(
                                  isLoading: _isLoggingOut,
                                  onPressed: () => _confirmLogout(context),
                                ),
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
