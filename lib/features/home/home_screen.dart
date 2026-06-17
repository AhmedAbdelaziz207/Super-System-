import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_system/core/di/dependency_injection.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/core/widgets/fade_in_up.dart';
import 'package:super_system/features/home/logic/home_cubit.dart';
import 'package:super_system/features/home/logic/home_states.dart';
import 'package:super_system/features/home/widgets/attendance_card.dart';
import 'package:super_system/features/home/widgets/excuses_card.dart';
import 'package:super_system/features/home/widgets/financial_card.dart';
import 'package:super_system/features/home/widgets/home_app_bar.dart';
import 'package:super_system/features/home/widgets/performance_card.dart';
import 'package:super_system/features/home/widgets/student_profile_card.dart';
import 'package:super_system/features/home/widgets/account_drawer.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onProfileTap;

  const HomeScreen({super.key, this.onProfileTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String studentName = '';
  String studentCode = '';
  String parentPhone = '';
  String groupName = '';

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  void _loadStudentData() {
    setState(() {
      studentName = StorageService().getString(StorageService.keyStudentName);
      studentCode = StorageService().getString(StorageService.keyStudentCode);
      parentPhone = StorageService().getString(StorageService.keyParentPhone);
      groupName = StorageService().getString(StorageService.keyGroupName);
    });
  }

  String _resolveGroupName(String? apiGroup, String cachedGroup) {
    if (apiGroup != null && apiGroup.isNotEmpty) return apiGroup;
    return cachedGroup;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getHomeStatistics(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.surface,
            endDrawer: AccountDrawer(
              onAccountSwitched: () {
                _loadStudentData();
                context.read<HomeCubit>().getHomeStatistics();
              },
            ),
            appBar: HomeAppBar(
              studentName: studentName,
              onProfileTap: widget.onProfileTap,
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  if (state is HomeLoading || state is HomeInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeFailure) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    );
                  } else if (state is HomeSuccess) {
                    final data = state.data;
                    int delayIndex = 0;
                    Duration getDelay() => Duration(milliseconds: 100 * delayIndex++);

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
                      child: Column(
                        children: [
                          FadeInUp(
                            delay: getDelay(),
                            child: StudentProfileCard(
                              studentName: studentName,
                              studentCode: studentCode,
                              parentPhone: parentPhone,
                              groupName: groupName,
                              generalAverage: data.academicPerformance?.lastExam?.percentage,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          if (data.attendanceStats != null) ...[
                            FadeInUp(
                              delay: getDelay(),
                              child: AttendanceCard(attendanceStats: data.attendanceStats!),
                            ),
                            SizedBox(height: 16.h),
                          ],
                          FadeInUp(
                            delay: getDelay(),
                            child: ExcusesCard(
                              requests: state.absenceRequests?.requests ?? [],
                              groupName: _resolveGroupName(
                                state.absenceRequests?.student.groupName,
                                groupName,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          if (data.academicPerformance?.lastExam != null) ...[
                            FadeInUp(
                              delay: getDelay(),
                              child: PerformanceCard(lastExam: data.academicPerformance!.lastExam!),
                            ),
                            SizedBox(height: 16.h),
                          ],
                          if (data.financialStatus != null) ...[
                            FadeInUp(
                              delay: getDelay(),
                              child: FinancialCard(financialStatus: data.financialStatus!, groupName: groupName),
                            ),
                            SizedBox(height: 32.h),
                          ],
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}