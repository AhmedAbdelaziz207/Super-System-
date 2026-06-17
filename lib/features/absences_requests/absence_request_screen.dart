import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/di/dependency_injection.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/widgets/fade_in_up.dart';
import 'package:super_system/features/absences_requests/logic/absence_request_cubit.dart';
import 'package:super_system/features/absences_requests/logic/absence_request_states.dart';
import 'package:super_system/features/absences_requests/widgets/absence_request_item_card.dart';
import 'package:super_system/features/absences_requests/widgets/absence_request_summary_row.dart';
import 'package:super_system/features/attendence/widgets/attendance_filters.dart';

class AbsenceRequestScreen extends StatelessWidget {
  const AbsenceRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AbsenceRequestCubit>()..getAbsenceRequests(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w, bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text(
                        'طلبات الغياب',
                        style: GoogleFonts.cairo(
                          color: AppColors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 40.w),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<AbsenceRequestCubit, AbsenceRequestStates>(
                    builder: (context, state) {
                      if (state is AbsenceRequestLoading || state is AbsenceRequestInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is AbsenceRequestFailure) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Text(
                                state.message,
                                style: const TextStyle(color: AppColors.error),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () => context.read<AbsenceRequestCubit>().getAbsenceRequests(),
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        );
                      }

                      if (state is AbsenceRequestSuccess) {
                        final data = state.data;
                        final cubit = context.read<AbsenceRequestCubit>();
                        int delayIndex = 0;
                        Duration getDelay() => Duration(milliseconds: 100 * delayIndex++);

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FadeInUp(
                                delay: getDelay(),
                                child: AttendanceFilters(
                                  selectedMonth: cubit.selectedMonth,
                                  selectedYear: cubit.selectedYear,
                                  onFilterChanged: cubit.updateFilters,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              FadeInUp(
                                delay: getDelay(),
                                child: AbsenceRequestSummaryRow(
                                  totalRequests: data.summary.totalRequests ?? 0,
                                  totalExcusedDays: data.summary.totalExcusedDays ?? 0,
                                ),
                              ),
                              SizedBox(height: 24.h),
                              FadeInUp(
                                delay: getDelay(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.tune_outlined,
                                      color: AppColors.onSurfaceVariant,
                                      size: 20.w,
                                    ),
                                    Text(
                                      'أحدث الطلبات',
                                      style: GoogleFonts.cairo(
                                        color: AppColors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              if (data.requests.isEmpty)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40.h),
                                  child: Center(
                                    child: Text(
                                      'لا توجد طلبات غياب لهذا الشهر',
                                      style: GoogleFonts.cairo(
                                        color: AppColors.onSurfaceVariant,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.requests.length,
                                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                                  itemBuilder: (context, index) {
                                    return FadeInUp(
                                      delay: getDelay(),
                                      child: AbsenceRequestItemCard(request: data.requests[index]),
                                    );
                                  },
                                ),
                            ],
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
