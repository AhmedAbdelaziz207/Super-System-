import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/di/dependency_injection.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/widgets/fade_in_up.dart';
import 'package:super_system/features/finance/logic/finance_cubit.dart';
import 'package:super_system/features/finance/logic/finance_states.dart';
import 'package:super_system/features/finance/model/finance_model.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FinanceCubit>()..getMonthlyExpenses(),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                // Top Custom App Bar with Year Filter
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.h,
                    left: 24.w,
                    right: 24.w,
                    bottom: 8.h,
                  ),
                  child: BlocBuilder<FinanceCubit, FinanceStates>(
                    builder: (context, state) {
                      final cubit = context.read<FinanceCubit>();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackgroundLight.withValues(
                                  alpha: 0.3,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.white,
                                size: 20.w,
                              ),
                            ),
                          ),

                          // Year Filter Dropdown
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackgroundLight.withValues(
                                alpha: 0.3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.cardBackgroundLight.withValues(
                                  alpha: 0.5,
                                ),
                                width: 1,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: cubit.selectedYear,
                                dropdownColor: AppColors.cardBackground,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.white,
                                  size: 20.w,
                                ),
                                style: GoogleFonts.cairo(
                                  color: AppColors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                items:
                                    cubit.availableYears.map((int year) {
                                      return DropdownMenuItem<int>(
                                        value: year,
                                        child: Text('$year'),
                                      );
                                    }).toList(),
                                onChanged: (int? newValue) {
                                  if (newValue != null) {
                                    cubit.updateYearFilter(newValue);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Content Body
                Expanded(
                  child: BlocBuilder<FinanceCubit, FinanceStates>(
                    builder: (context, state) {
                      if (state is FinanceLoading || state is FinanceInitial) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FinanceFailure) {
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
                              onPressed:
                                  () =>
                                      context
                                          .read<FinanceCubit>()
                                          .getMonthlyExpenses(),
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        );
                      } else if (state is FinanceSuccess) {
                        final data = state.data;
                        final summary = data.summary ?? FinanceSummary.empty();

                        int delayIndex = 0;
                        Duration getDelay() =>
                            Duration(milliseconds: 100 * delayIndex++);

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 16.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Header Title
                              FadeInUp(
                                delay: getDelay(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'السجلات المالية',
                                      style: GoogleFonts.cairo(
                                        color: AppColors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'نظرة عامة على مدفوعاتك واشتراكاتك',
                                      style: GoogleFonts.cairo(
                                        color: AppColors.onSurfaceVariant,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24.h),

                              // Total Paid Amount Card
                              FadeInUp(
                                delay: getDelay(),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.cardBackgroundLight
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColors.cardBackgroundLight
                                          .withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Credit card icon
                                      Container(
                                        padding: EdgeInsets.all(12.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.cardBackgroundLight
                                              .withValues(alpha: 0.5),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.credit_card_outlined,
                                          color: const Color(0xFFC29CFC),
                                          size: 26.w,
                                        ),
                                      ),

                                      // Numeric dynamic sum
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'إجمالي المبلغ المدفوع',
                                            style: GoogleFonts.cairo(
                                              color: AppColors.onSurfaceVariant,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            'EGP ${summary.totalPaidAmount ?? 0}',
                                            style: GoogleFonts.cairo(
                                              color: AppColors.white,
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),

                              // Months Paid and Months Remaining Cards
                              FadeInUp(
                                delay: getDelay(),
                                child: Row(
                                  children: [
                                    // Months remaining card
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(16.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.cardBackgroundLight
                                              .withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: AppColors.cardBackgroundLight
                                                .withValues(alpha: 0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'أشهر متبقية',
                                              style: GoogleFonts.cairo(
                                                color:
                                                    AppColors.onSurfaceVariant,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              '${summary.totalNotPaid ?? 0} شهر',
                                              style: GoogleFonts.cairo(
                                                color: AppColors.white,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),

                                    // Months paid card
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(16.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.cardBackgroundLight
                                              .withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: AppColors.cardBackgroundLight
                                                .withValues(alpha: 0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'أشهر مدفوعة',
                                              style: GoogleFonts.cairo(
                                                color:
                                                    AppColors.onSurfaceVariant,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              '${summary.totalPaid ?? 0} أشهر',
                                              style: GoogleFonts.cairo(
                                                color: AppColors.white,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 28.h),

                              // Monthly Payments Title Section
                              FadeInUp(
                                delay: getDelay(),
                                child: Text(
                                  'تفاصيل الدفع الشهرية',
                                  style: GoogleFonts.cairo(
                                    color: AppColors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),

                              // Months List
                              if (data.months == null ||
                                  data.months!.isEmpty) ...[
                                SizedBox(height: 40.h),
                                Center(
                                  child: Text(
                                    'لا توجد سجلات مالية متوفرة لهذا العام',
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
                                  itemCount: data.months!.length,
                                  separatorBuilder:
                                      (context, index) =>
                                          SizedBox(height: 12.h),
                                  itemBuilder: (context, index) {
                                    return FadeInUp(
                                      delay: getDelay(),
                                      child: _buildMonthItemCard(
                                        data.months![index],
                                      ),
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

  Widget _buildMonthItemCard(FinanceMonth month) {
    final bool isPaid = month.paymentStatus == 'paid';
    final int amount =
        isPaid
            ? (month.paymentDetails?.monthlyPaymentAtPayment ?? 500)
            : (month.expectedAmount?.fullPayment ?? 500);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLight.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Top row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price tag
              Text(
                'EGP $amount',
                style: GoogleFonts.cairo(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Status & Label Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    month.fullLabel ?? '',
                    style: GoogleFonts.cairo(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        isPaid ? 'تم الدفع' : 'غير مدفوع',
                        style: GoogleFonts.cairo(
                          color: isPaid ? AppColors.success : AppColors.warning,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        isPaid
                            ? Icons.check_circle_outline
                            : Icons.watch_later_outlined,
                        color: isPaid ? AppColors.success : AppColors.warning,
                        size: 14.w,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Bottom Dynamic details
          if (isPaid) ...[
            SizedBox(height: 12.h),
            Divider(
              color: AppColors.cardBackgroundLight.withValues(alpha: 0.5),
              height: 1,
            ),
            SizedBox(height: 12.h),

            // Payment details sub list
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'كود المصروفات',
                      style: GoogleFonts.cairo(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      month.paymentDetails?.expenseCode ?? '',
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'تاريخ الدفع',
                      style: GoogleFonts.cairo(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      month.paymentDetails?.paymentDate ?? '',
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ] else
            ...[],
        ],
      ),
    );
  }
}
