import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';

class AttendanceFilters extends StatelessWidget {
  final int selectedMonth;
  final int selectedYear;
  final Function(int month, int year) onFilterChanged;

  const AttendanceFilters({
    super.key,
    required this.selectedMonth,
    required this.selectedYear,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Generate recent years (e.g. 2024 to 2028)
    final List<int> years = List.generate(5, (index) => 2024 + index);
    
    // Arabic Months list
    final List<Map<String, dynamic>> months = [
      {'value': 1, 'name': 'يناير'},
      {'value': 2, 'name': 'فبراير'},
      {'value': 3, 'name': 'مارس'},
      {'value': 4, 'name': 'أبريل'},
      {'value': 5, 'name': 'مايو'},
      {'value': 6, 'name': 'يونيو'},
      {'value': 7, 'name': 'يوليو'},
      {'value': 8, 'name': 'أغسطس'},
      {'value': 9, 'name': 'سبتمبر'},
      {'value': 10, 'name': 'أكتوبر'},
      {'value': 11, 'name': 'نوفمبر'},
      {'value': 12, 'name': 'ديسمبر'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Year filter
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBackgroundLight, width: 1),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedYear,
                dropdownColor: AppColors.surface,
                icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                isExpanded: true,
                items: years.map((year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text(
                      year.toString(),
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (year) {
                  if (year != null) {
                    onFilterChanged(selectedMonth, year);
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Month filter
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.cardBackgroundLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBackgroundLight, width: 1),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedMonth,
                dropdownColor: AppColors.surface,
                icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                isExpanded: true,
                items: months.map((month) {
                  return DropdownMenuItem<int>(
                    value: month['value'],
                    child: Text(
                      month['name'],
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  );
                }).toList(),
                onChanged: (month) {
                  if (month != null) {
                    onFilterChanged(month, selectedYear);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
