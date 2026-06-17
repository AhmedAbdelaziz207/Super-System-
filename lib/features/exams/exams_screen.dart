import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/di/dependency_injection.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/widgets/fade_in_up.dart';
import 'package:super_system/features/exams/logic/exams_cubit.dart';
import 'package:super_system/features/exams/logic/exams_states.dart';
import 'package:super_system/features/exams/widgets/exam_item_card.dart';
import 'package:super_system/features/exams/widgets/exams_header.dart';
import 'package:super_system/features/exams/widgets/exams_summary_row.dart';

class ExamsScreen extends StatelessWidget {
  final bool showBackButton;

  const ExamsScreen({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExamsCubit>()..getExamsResults(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                // Top Custom Navigation Bar
                Padding(
                  padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w, bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (showBackButton)
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
                        'نتائج الاختبارات',
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
                
                // Content Body
                Expanded(
                  child: BlocBuilder<ExamsCubit, ExamsStates>(
                    builder: (context, state) {
                      if (state is ExamsLoading || state is ExamsInitial) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ExamsFailure) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              style: const TextStyle(color: AppColors.error),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () => context.read<ExamsCubit>().getExamsResults(),
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        );
                      } else if (state is ExamsSuccess) {
                        final data = state.data;

                        int delayIndex = 0;
                        Duration getDelay() => Duration(milliseconds: 100 * delayIndex++);

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Board header card
                              FadeInUp(
                                delay: getDelay(),
                                child: ExamsHeader(student: data.student),
                              ),
                              SizedBox(height: 24.h),

                              // Metric counters
                              FadeInUp(
                                delay: getDelay(),
                                child: ExamsSummaryRow(summary: data.summary),
                              ),
                              SizedBox(height: 24.h),

                              // Details Section Title
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
                                      'تفاصيل الاختبارات',
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

                              // Exam list
                              if (data.exams.isEmpty) ...[
                                SizedBox(height: 40.h),
                                Center(
                                  child: Text(
                                    'لا توجد اختبارات مضافة حالياً',
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
                                  itemCount: data.exams.length,
                                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                                  itemBuilder: (context, index) {
                                    return FadeInUp(
                                      delay: getDelay(),
                                      child: ExamItemCard(exam: data.exams[index]),
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
}
