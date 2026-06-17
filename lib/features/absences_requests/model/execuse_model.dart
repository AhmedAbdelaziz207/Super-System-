import 'package:super_system/features/attendence/model/attendence_model.dart';

class ExecuseModel {
  final String status;
  final ExecuseFilters filters;
  final Student student;
  final ExecuseSummary summary;
  final List<ExecuseRequest> requests;

  ExecuseModel({
    required this.status,
    required this.filters,
    required this.student,
    required this.summary,
    required this.requests,
  });

  factory ExecuseModel.fromJson(Map<String, dynamic> json) => ExecuseModel(
    status: json['status'] as String? ?? '',
    filters:
        json['filters'] != null
            ? ExecuseFilters.fromJson(json['filters'] as Map<String, dynamic>)
            : ExecuseFilters(),
    student:
        json['student'] != null
            ? Student.fromJson(json['student'] as Map<String, dynamic>)
            : Student(
              studentCode: '',
              studentName: '',
              academicYear: '',
              groupName: '',
            ),
    summary:
        json['summary'] != null
            ? ExecuseSummary.fromJson(json['summary'] as Map<String, dynamic>)
            : ExecuseSummary(),
    requests:
        json['requests'] != null
            ? List<ExecuseRequest>.from(
              (json['requests'] as List).map(
                (x) => ExecuseRequest.fromJson(x as Map<String, dynamic>),
              ),
            )
            : [],
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'filters': filters.toJson(),
    'student': student.toJson(),
    'summary': summary.toJson(),
    'requests': requests.map((x) => x.toJson()).toList(),
  };
}

class ExecuseFilters {
  final int? month;
  final int? year;

  ExecuseFilters({this.month, this.year});

  factory ExecuseFilters.fromJson(Map<String, dynamic> json) =>
      ExecuseFilters(month: json['month'] as int?, year: json['year'] as int?);

  Map<String, dynamic> toJson() => {'month': month, 'year': year};
}

class ExecuseSummary {
  final int? totalRequests;
  final int? totalExcusedDays;

  ExecuseSummary({this.totalRequests, this.totalExcusedDays});

  factory ExecuseSummary.fromJson(Map<String, dynamic> json) => ExecuseSummary(
    totalRequests: json['total_requests'] as int?,
    totalExcusedDays: json['total_excused_days'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'total_requests': totalRequests,
    'total_excused_days': totalExcusedDays,
  };
}

class ExecuseRequest {
  final String? requestCode;
  final String? requestedBy;
  final String? reason;
  final int? totalAbsenceDates;
  final List<ExecuseAbsenceDate> absenceDates;
  final ExecuseSubmittedBy? submittedBy;
  final ExecuseSubmittedAt? submittedAt;
  final String? updatedAt;

  ExecuseRequest({
    this.requestCode,
    this.requestedBy,
    this.reason,
    this.totalAbsenceDates,
    this.absenceDates = const [],
    this.submittedBy,
    this.submittedAt,
    this.updatedAt,
  });

  factory ExecuseRequest.fromJson(Map<String, dynamic> json) => ExecuseRequest(
    requestCode: json['request_code'] as String?,
    requestedBy: json['requested_by'] as String?,
    reason: json['reason'] as String?,
    totalAbsenceDates: json['total_absence_dates'] as int?,
    absenceDates:
        json['absence_dates'] != null
            ? List<ExecuseAbsenceDate>.from(
              (json['absence_dates'] as List).map(
                (x) => ExecuseAbsenceDate.fromJson(x as Map<String, dynamic>),
              ),
            )
            : [],
    submittedBy:
        json['submitted_by'] != null
            ? ExecuseSubmittedBy.fromJson(
              json['submitted_by'] as Map<String, dynamic>,
            )
            : null,
    submittedAt:
        json['submitted_at'] != null
            ? ExecuseSubmittedAt.fromJson(
              json['submitted_at'] as Map<String, dynamic>,
            )
            : null,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'request_code': requestCode,
    'requested_by': requestedBy,
    'reason': reason,
    'total_absence_dates': totalAbsenceDates,
    'absence_dates': absenceDates.map((x) => x.toJson()).toList(),
    'submitted_by': submittedBy?.toJson(),
    'submitted_at': submittedAt?.toJson(),
    'updated_at': updatedAt,
  };
}

class ExecuseAbsenceDate {
  final String? absenceDate;
  final int? dayNumber;
  final String? dayName;
  final int? monthNumber;
  final String? monthName;
  final int? year;

  ExecuseAbsenceDate({
    this.absenceDate,
    this.dayNumber,
    this.dayName,
    this.monthNumber,
    this.monthName,
    this.year,
  });

  factory ExecuseAbsenceDate.fromJson(Map<String, dynamic> json) =>
      ExecuseAbsenceDate(
        absenceDate: json['absence_date'] as String?,
        dayNumber: json['day_number'] as int?,
        dayName: json['day_name'] as String?,
        monthNumber: json['month_number'] as int?,
        monthName: json['month_name'] as String?,
        year: json['year'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'absence_date': absenceDate,
    'day_number': dayNumber,
    'day_name': dayName,
    'month_number': monthNumber,
    'month_name': monthName,
    'year': year,
  };
}

class ExecuseSubmittedBy {
  final String? assistantCode;
  final String? assistantName;

  ExecuseSubmittedBy({this.assistantCode, this.assistantName});

  factory ExecuseSubmittedBy.fromJson(Map<String, dynamic> json) =>
      ExecuseSubmittedBy(
        assistantCode: json['assistant_code'] as String?,
        assistantName: json['assistant_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'assistant_code': assistantCode,
    'assistant_name': assistantName,
  };
}

class ExecuseSubmittedAt {
  final String? datetime;
  final int? dayNumber;
  final String? dayName;
  final int? monthNumber;
  final String? monthName;
  final int? year;

  ExecuseSubmittedAt({
    this.datetime,
    this.dayNumber,
    this.dayName,
    this.monthNumber,
    this.monthName,
    this.year,
  });

  factory ExecuseSubmittedAt.fromJson(Map<String, dynamic> json) =>
      ExecuseSubmittedAt(
        datetime: json['datetime'] as String?,
        dayNumber: json['day_number'] as int?,
        dayName: json['day_name'] as String?,
        monthNumber: json['month_number'] as int?,
        monthName: json['month_name'] as String?,
        year: json['year'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'datetime': datetime,
    'day_number': dayNumber,
    'day_name': dayName,
    'month_number': monthNumber,
    'month_name': monthName,
    'year': year,
  };
}
