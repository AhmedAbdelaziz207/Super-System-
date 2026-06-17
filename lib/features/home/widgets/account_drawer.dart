import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/routing/app_routes.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/utils/storage_service.dart';

class AccountDrawer extends StatefulWidget {
  final VoidCallback? onAccountSwitched;

  const AccountDrawer({super.key, this.onAccountSwitched});

  @override
  State<AccountDrawer> createState() => _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer> {
  List<Map<String, dynamic>> _accounts = [];
  String _currentCode = '';
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  void _loadAccounts() {
    _currentCode = _storageService.getString(StorageService.keyStudentCode);
    
    // Ensure current active account is saved
    _storageService.saveCurrentAccountToList();

    final savedList = _storageService.getSavedAccounts();

    // Filter out any previously stored mock/fake accounts from local storage
    final originalLength = savedList.length;
    savedList.removeWhere((account) =>
        account['studentCode'] == 'STD-00002' ||
        account['studentCode'] == 'STD-00003' ||
        account['userToken'] == 'mock_token_1' ||
        account['userToken'] == 'mock_token_2' ||
        account['userToken'] == 'mock_token_3');

    if (savedList.length != originalLength) {
      _storageService.save(StorageService.keySavedAccounts, json.encode(savedList));
    }

    setState(() {
      _accounts = savedList;
    });
  }

  String _getAcademicYearArabic(String? academicYear) {
    if (academicYear == null || academicYear.isEmpty) return 'طالب';
    switch (academicYear) {
      case 'third_secondary':
        return 'الصف الثالث الثانوي';
      case 'second_secondary':
        return 'الصف الثاني الثانوي';
      case 'first_secondary':
        return 'الصف الأول الثانوي';
      case 'sixth_primary':
        return 'الصف السادس الابتدائي';
      default:
        return academicYear;
    }
  }

  Future<void> _handleSwitchAccount(String studentCode) async {
    if (studentCode == _currentCode) {
      Navigator.pop(context);
      return;
    }

    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );

    await _storageService.switchAccount(studentCode);
    
    if (mounted) {
      Navigator.pop(context); // Close loading overlay
      Navigator.pop(context); // Close Drawer
      if (widget.onAccountSwitched != null) {
        widget.onAccountSwitched!();
      }
    }
  }

  Future<void> _handleAddStudent() async {
    // Save current state first
    await _storageService.saveCurrentAccountToList();
    if (mounted) {
      Navigator.pop(context); // Close Drawer
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290.w,
      child: Drawer(
        elevation: 16,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33085A), // Deep violet
                Color(0xFF130324), // Dark deep purple
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'تبديل الحساب',
                          style: GoogleFonts.cairo(
                            color: AppColors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(Icons.close, color: AppColors.white, size: 24.w),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    // Subtitle
                    Text(
                      'الأبناء المسجلون',
                      style: GoogleFonts.cairo(
                        color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Account List
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _accounts.length,
                        separatorBuilder: (ctx, index) => SizedBox(height: 12.h),
                        itemBuilder: (ctx, index) {
                          final account = _accounts[index];
                          final isSelected = account['studentCode'] == _currentCode;
                          
                          return InkWell(
                            onTap: () => _handleSwitchAccount(account['studentCode']),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF4C1580).withValues(alpha: 0.4)
                                    : const Color(0xFF28113B).withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary.withValues(alpha: 0.8)
                                      : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Selection checkmark or empty space
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: AppColors.primary,
                                      size: 20.w,
                                    )
                                  else
                                    SizedBox(width: 20.w),
                                  const Spacer(),
                                  // Text details
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        account['studentName'] ?? '',
                                        style: GoogleFonts.cairo(
                                          color: AppColors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        isSelected 
                                            ? 'الحساب الحالي' 
                                            : _getAcademicYearArabic(account['academicYear']),
                                        style: GoogleFonts.cairo(
                                          color: isSelected 
                                              ? AppColors.primary 
                                              : AppColors.onSurfaceVariant.withValues(alpha: 0.8),
                                          fontSize: 11.sp,
                                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 12.w),
                                  // Profile Photo or Icon
                                  if (account['studentCode'] == 'STD-00001' || (isSelected && index == 0))
                                    CircleAvatar(
                                      radius: 20.w,
                                      backgroundImage: const NetworkImage(
                                        'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100&auto=format&fit=crop',
                                      ),
                                    )
                                  else
                                    CircleAvatar(
                                      radius: 20.w,
                                      backgroundColor: const Color(0xFF3C2053),
                                      child: Icon(
                                        Icons.person_outline,
                                        color: AppColors.onSurfaceVariant,
                                        size: 20.w,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Add student button at the bottom
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: OutlinedButton(
                        onPressed: _handleAddStudent,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.5), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'إضافة طالب جديد',
                              style: GoogleFonts.cairo(
                                color: AppColors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.add, color: AppColors.white, size: 18.w),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
