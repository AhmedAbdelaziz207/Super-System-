import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/di/dependency_injection.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/widgets/fade_in_up.dart';
import 'package:super_system/features/attendence/logic/attendence_cubit.dart';
import 'package:super_system/features/attendence/logic/attendence_states.dart';
import 'package:super_system/features/attendence/widgets/absence_note.dart';
import 'package:super_system/features/attendence/widgets/absence_record_card.dart';
import 'package:super_system/features/attendence/widgets/absence_summary_card.dart';
import 'package:super_system/features/attendence/widgets/attendance_filters.dart';
import 'package:super_system/features/attendence/widgets/attendance_student_card.dart';

class AttendenceScreen extends StatelessWidget {
  const AttendenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AttendenceCubit>()..getAttendance(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                // Top Header (Back button and title)
                Padding(
                  padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w, bottom: 8.h),
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
                      Text(
                        'سجل الغياب',
                        style: GoogleFonts.cairo(
                          color: AppColors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Content Body
                Expanded(
                  child: BlocBuilder<AttendenceCubit, AttendenceStates>(
                    builder: (context, state) {
                      if (state is AttendenceLoading || state is AttendenceInitial) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AttendenceFailure) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              style: const TextStyle(color: AppColors.error),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () => context.read<AttendenceCubit>().getAttendance(),
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        );
                      } else if (state is AttendenceSuccess) {
                        final data = state.data;
                        final cubit = context.read<AttendenceCubit>();

                        int delayIndex = 0;
                        Duration getDelay() => Duration(milliseconds: 100 * delayIndex++);

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Student Details Header
                              FadeInUp(
                                delay: getDelay(),
                                child: AttendanceStudentCard(student: data.student),
                              ),
                              SizedBox(height: 24.h),

                              // Total Absences summary Card
                              FadeInUp(
                                delay: getDelay(),
                                child: AbsenceSummaryCard(totalAbsent: data.totalAbsent),
                              ),
                              SizedBox(height: 16.h),

                              // Info note
                              FadeInUp(
                                delay: getDelay(),
                                child: AbsenceNote(note: data.note),
                              ),
                              SizedBox(height: 24.h),

                              // Filters Row (Month & Year)
                              FadeInUp(
                                delay: getDelay(),
                                child: AttendanceFilters(
                                  selectedMonth: cubit.selectedMonth,
                                  selectedYear: cubit.selectedYear,
                                  onFilterChanged: (month, year) {
                                    cubit.updateFilters(month, year);
                                  },
                                ),
                              ),
                              SizedBox(height: 24.h),

                              // Dynamic Month & Year title header (e.g. | أبريل 2026)
                              FadeInUp(
                                delay: getDelay(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${_getMonthName(cubit.selectedMonth)} ${cubit.selectedYear}',
                                      style: GoogleFonts.cairo(
                                        color: AppColors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Container(
                                      width: 4.w,
                                      height: 20.h,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // Absences List
                              if (data.absenceRecords.isEmpty) ...[
                                SizedBox(height: 32.h),
                                Center(
                                  child: Text(
                                    'لا توجد حالات غياب في هذا الشهر',
                                    style: GoogleFonts.cairo(
                                      color: AppColors.onSurfaceVariant,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.absenceRecords.length,
                                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                                  itemBuilder: (context, index) {
                                    return FadeInUp(
                                      delay: getDelay(),
                                      child: AbsenceRecordCard(record: data.absenceRecords[index]),
                                    );
                                  },
                                ),
                              ],
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

  String _getMonthName(int monthValue) {
    const monthNames = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    if (monthValue >= 1 && monthValue <= 12) {
      return monthNames[monthValue - 1];
    }
    return '';
  }
}
