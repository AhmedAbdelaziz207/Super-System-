// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
  status: json['status'] as String?,
  attendanceStats:
      json['attendance_stats'] == null
          ? null
          : AttendanceStats.fromJson(
            json['attendance_stats'] as Map<String, dynamic>,
          ),
  academicPerformance:
      json['academic_performance'] == null
          ? null
          : AcademicPerformance.fromJson(
            json['academic_performance'] as Map<String, dynamic>,
          ),
  financialStatus:
      json['financial_status'] == null
          ? null
          : FinancialStatus.fromJson(
            json['financial_status'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'attendance_stats': instance.attendanceStats,
      'academic_performance': instance.academicPerformance,
      'financial_status': instance.financialStatus,
    };

AttendanceStats _$AttendanceStatsFromJson(Map<String, dynamic> json) =>
    AttendanceStats(
      currentMonth: (json['current_month'] as num?)?.toInt(),
      currentYear: (json['current_year'] as num?)?.toInt(),
      monthName: json['month_name'] as String?,
      totalStudyDays: (json['total_study_days'] as num?)?.toInt(),
      attendedDays: (json['attended_days'] as num?)?.toInt(),
      excusedDays: (json['excused_days'] as num?)?.toInt(),
      absentDays: (json['absent_days'] as num?)?.toInt(),
      commitmentRate: json['commitment_rate'] as String?,
      lastAttendance:
          json['last_attendance'] == null
              ? null
              : LastAttendance.fromJson(
                json['last_attendance'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$AttendanceStatsToJson(AttendanceStats instance) =>
    <String, dynamic>{
      'current_month': instance.currentMonth,
      'current_year': instance.currentYear,
      'month_name': instance.monthName,
      'total_study_days': instance.totalStudyDays,
      'attended_days': instance.attendedDays,
      'excused_days': instance.excusedDays,
      'absent_days': instance.absentDays,
      'commitment_rate': instance.commitmentRate,
      'last_attendance': instance.lastAttendance,
    };

LastAttendance _$LastAttendanceFromJson(Map<String, dynamic> json) =>
    LastAttendance(
      date: json['date'] as String?,
      dayName: json['day_name'] as String?,
      time: json['time'] as String?,
      groupName: json['group_name'] as String?,
    );

Map<String, dynamic> _$LastAttendanceToJson(LastAttendance instance) =>
    <String, dynamic>{
      'date': instance.date,
      'day_name': instance.dayName,
      'time': instance.time,
      'group_name': instance.groupName,
    };

AcademicPerformance _$AcademicPerformanceFromJson(Map<String, dynamic> json) =>
    AcademicPerformance(
      lastExam:
          json['last_exam'] == null
              ? null
              : LastExam.fromJson(json['last_exam'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcademicPerformanceToJson(
  AcademicPerformance instance,
) => <String, dynamic>{'last_exam': instance.lastExam};

LastExam _$LastExamFromJson(Map<String, dynamic> json) => LastExam(
  examCode: json['exam_code'] as String?,
  examName: json['exam_name'] as String?,
  studentGrade: (json['student_grade'] as num?)?.toInt(),
  totalGrade: (json['total_grade'] as num?)?.toInt(),
  percentage: json['percentage'] as String?,
  passed: json['passed'] as bool?,
  gradedAt: json['graded_at'] as String?,
);

Map<String, dynamic> _$LastExamToJson(LastExam instance) => <String, dynamic>{
  'exam_code': instance.examCode,
  'exam_name': instance.examName,
  'student_grade': instance.studentGrade,
  'total_grade': instance.totalGrade,
  'percentage': instance.percentage,
  'passed': instance.passed,
  'graded_at': instance.gradedAt,
};

FinancialStatus _$FinancialStatusFromJson(Map<String, dynamic> json) =>
    FinancialStatus(
      isExempt: json['is_exempt'] as bool?,
      monthlyFee: (json['monthly_fee'] as num?)?.toInt(),
      paymentType: json['payment_type'] as String?,
      paymentTypeLabel: json['payment_type_label'] as String?,
      expectedAmount: (json['expected_amount'] as num?)?.toInt(),
      isPaid: json['is_paid'] as bool?,
      paymentDate: json['payment_date'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FinancialStatusToJson(FinancialStatus instance) =>
    <String, dynamic>{
      'is_exempt': instance.isExempt,
      'monthly_fee': instance.monthlyFee,
      'payment_type': instance.paymentType,
      'payment_type_label': instance.paymentTypeLabel,
      'expected_amount': instance.expectedAmount,
      'is_paid': instance.isPaid,
      'payment_date': instance.paymentDate,
      'message': instance.message,
    };
