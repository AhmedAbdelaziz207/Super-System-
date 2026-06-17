// {
//     "status": "success",
//     "attendance_stats": {
//         "current_month": 5,
//         "current_year": 2026,
//         "month_name": "مايو",
//         "total_study_days": 22,
//         "attended_days": 18,
//         "excused_days": 2,
//         "absent_days": 2,
//         "commitment_rate": "81.82%",
//         "last_attendance": {
//             "date": "2026-05-16",
//             "day_name": "السبت",
//             "time": "10:30",
//             "group_name": "مجموعة الأثنين أ"
//         }
//     },
//     "academic_performance": {
//         "last_exam": {
//             "exam_code": "EXM-AB12C",
//             "exam_name": "امتحان الفيزياء الشهري",
//             "student_grade": 92,
//             "total_grade": 100,
//             "percentage": "92%",
//             "passed": true,
//             "graded_at": "2026-05-15 14:30:00"
//         }
//     },
//     "financial_status": {
//         "is_exempt": false,
//         "monthly_fee": 300,
//         "payment_type": "full",
//         "payment_type_label": "كامل",
//         "expected_amount": 300,
//         "is_paid": true,
//         "payment_date": "2026-05-01",
//         "message": "تم دفع مصاريف الشهر الحالي"
//     }
// }

import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'attendance_stats')
  final AttendanceStats? attendanceStats;
  @JsonKey(name: 'academic_performance')
  final AcademicPerformance? academicPerformance;
  @JsonKey(name: 'financial_status')
  final FinancialStatus? financialStatus;

  HomeResponse({
    this.status,
    this.attendanceStats,
    this.academicPerformance,
    this.financialStatus,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class AttendanceStats {
  @JsonKey(name: 'current_month')
  final int? currentMonth;
  @JsonKey(name: 'current_year')
  final int? currentYear;
  @JsonKey(name: 'month_name')
  final String? monthName;
  @JsonKey(name: 'total_study_days')
  final int? totalStudyDays;
  @JsonKey(name: 'attended_days')
  final int? attendedDays;
  @JsonKey(name: 'excused_days')
  final int? excusedDays;
  @JsonKey(name: 'absent_days')
  final int? absentDays;
  @JsonKey(name: 'commitment_rate')
  final String? commitmentRate;
  @JsonKey(name: 'last_attendance')
  final LastAttendance? lastAttendance;

  AttendanceStats({
    this.currentMonth,
    this.currentYear,
    this.monthName,
    this.totalStudyDays,
    this.attendedDays,
    this.excusedDays,
    this.absentDays,
    this.commitmentRate,
    this.lastAttendance,
  });

  factory AttendanceStats.fromJson(Map<String, dynamic> json) =>
      _$AttendanceStatsFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceStatsToJson(this);
}

@JsonSerializable()
class LastAttendance {
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'day_name')
  final String? dayName;
  @JsonKey(name: 'time')
  final String? time;
  @JsonKey(name: 'group_name')
  final String? groupName;

  LastAttendance({this.date, this.dayName, this.time, this.groupName});

  factory LastAttendance.fromJson(Map<String, dynamic> json) =>
      _$LastAttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$LastAttendanceToJson(this);
}

@JsonSerializable()
class AcademicPerformance {
  @JsonKey(name: 'last_exam')
  final LastExam? lastExam;

  AcademicPerformance({this.lastExam});

  factory AcademicPerformance.fromJson(Map<String, dynamic> json) =>
      _$AcademicPerformanceFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicPerformanceToJson(this);
}

@JsonSerializable()
class LastExam {
  @JsonKey(name: 'exam_code')
  final String? examCode;
  @JsonKey(name: 'exam_name')
  final String? examName;
  @JsonKey(name: 'student_grade')
  final int? studentGrade;
  @JsonKey(name: 'total_grade')
  final int? totalGrade;
  @JsonKey(name: 'percentage')
  final String? percentage;
  @JsonKey(name: 'passed')
  final bool? passed;
  @JsonKey(name: 'graded_at')
  final String? gradedAt;

  LastExam({
    this.examCode,
    this.examName,
    this.studentGrade,
    this.totalGrade,
    this.percentage,
    this.passed,
    this.gradedAt,
  });

  factory LastExam.fromJson(Map<String, dynamic> json) =>
      _$LastExamFromJson(json);

  Map<String, dynamic> toJson() => _$LastExamToJson(this);
}

@JsonSerializable()
class FinancialStatus {
  @JsonKey(name: 'is_exempt')
  final bool? isExempt;
  @JsonKey(name: 'monthly_fee')
  final int? monthlyFee;
  @JsonKey(name: 'payment_type')
  final String? paymentType;
  @JsonKey(name: 'payment_type_label')
  final String? paymentTypeLabel;
  @JsonKey(name: 'expected_amount')
  final int? expectedAmount;
  @JsonKey(name: 'is_paid')
  final bool? isPaid;
  @JsonKey(name: 'payment_date')
  final String? paymentDate;
  @JsonKey(name: 'message')
  final String? message;

  FinancialStatus({
    this.isExempt,
    this.monthlyFee,
    this.paymentType,
    this.paymentTypeLabel,
    this.expectedAmount,
    this.isPaid,
    this.paymentDate,
    this.message,
  });

  factory FinancialStatus.fromJson(Map<String, dynamic> json) =>
      _$FinancialStatusFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialStatusToJson(this);
}
