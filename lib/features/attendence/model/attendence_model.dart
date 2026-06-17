// {
//     "status": "success",
//     "type": "absence",
//     "filters": {
//         "month": 4,
//         "year": 2026
//     },
//     "student": {
//         "student_code": "STD-00001",
//         "student_name": "محمد أحمد",
//         "academic_year": "third_secondary",
//         "group_name": "مجموعة الأحد"
//     },
//     "group_schedule": [
//         {
//             "day_number": 0,
//             "day_name": "الأحد",
//             "start_time": "10:00:00",
//             "end_time": "12:00:00"
//         }
//     ],
//     "note": "التواريخ المستأذنة مستبعدة من سجل الغياب",
//     "total_absent": 1,
//     "absence_records": [
//         {
//             "absence_date": "2026-04-06",
//             "day_number": 0,
//             "day_name": "الأحد",
//             "month_number": 4,
//             "month_name": "أبريل",
//             "year": 2026,
//             "session_start": "10:00:00",
//             "session_end": "12:00:00"
//         }
//     ]
// }


class AttendenceModel {
  final String status;
  final String type;
  final Filters filters;
  final Student student;
  final List<GroupSchedule> groupSchedule;
  final String note;
  final int totalAbsent;
  final List<AbsenceRecord> absenceRecords;

  AttendenceModel({
    required this.status,
    required this.type,
    required this.filters,
    required this.student,
    required this.groupSchedule,
    required this.note,
    required this.totalAbsent,
    required this.absenceRecords,
  });

  factory AttendenceModel.fromJson(Map<String, dynamic> json) => AttendenceModel(
        status: json['status'],
        type: json['type'],
        filters: Filters.fromJson(json['filters']),
        student: Student.fromJson(json['student']),
        groupSchedule: List<GroupSchedule>.from(
          json['group_schedule'].map((x) => GroupSchedule.fromJson(x)),
        ),
        note: json['note'],
        totalAbsent: json['total_absent'],
        absenceRecords: List<AbsenceRecord>.from(
          json['absence_records'].map((x) => AbsenceRecord.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'type': type,
        'filters': filters.toJson(),
        'student': student.toJson(),
        'group_schedule': List<dynamic>.from(groupSchedule.map((x) => x.toJson())),
        'note': note,
        'total_absent': totalAbsent,
        'absence_records': List<dynamic>.from(absenceRecords.map((x) => x.toJson())),
      };
}

class AbsenceRecord {
  final String absenceDate;
  final int dayNumber;
  final String dayName;
  final int monthNumber;
  final String monthName;
  final int year;
  final String sessionStart;
  final String sessionEnd;

  AbsenceRecord({
    required this.absenceDate,
    required this.dayNumber,
    required this.dayName,
    required this.monthNumber,
    required this.monthName,
    required this.year,
    required this.sessionStart,
    required this.sessionEnd,
  });

  factory AbsenceRecord.fromJson(Map<String, dynamic> json) => AbsenceRecord(
        absenceDate: json['absence_date'],
        dayNumber: json['day_number'],
        dayName: json['day_name'],
        monthNumber: json['month_number'],
        monthName: json['month_name'],
        year: json['year'],
        sessionStart: json['session_start'],
        sessionEnd: json['session_end'],
      );

  Map<String, dynamic> toJson() => {
        'absence_date': absenceDate,
        'day_number': dayNumber,
        'day_name': dayName,
        'month_number': monthNumber,
        'month_name': monthName,
        'year': year,
        'session_start': sessionStart,
        'session_end': sessionEnd,
      };
}

class Filters {
  final int month;
  final int year;

  Filters({
    required this.month,
    required this.year,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        month: json['month'],
        year: json['year'],
      );

  Map<String, dynamic> toJson() => {
        'month': month,
        'year': year,
      };
}

class GroupSchedule {
  final int dayNumber;
  final String dayName;
  final String startTime;
  final String endTime;

  GroupSchedule({
    required this.dayNumber,
    required this.dayName,
    required this.startTime,
    required this.endTime,
  });

  factory GroupSchedule.fromJson(Map<String, dynamic> json) => GroupSchedule(
        dayNumber: json['day_number'],
        dayName: json['day_name'],
        startTime: json['start_time'],
        endTime: json['end_time'],
      );

  Map<String, dynamic> toJson() => {
        'day_number': dayNumber,
        'day_name': dayName,
        'start_time': startTime,
        'end_time': endTime,
      };
}

class Student {
  final String studentCode;
  final String studentName;
  final String academicYear;
  final String groupName;

  Student({
    required this.studentCode,
    required this.studentName,
    required this.academicYear,
    required this.groupName,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentCode: json['student_code'],
        studentName: json['student_name'],
        academicYear: json['academic_year'],
        groupName: json['group_name'],
      );

  Map<String, dynamic> toJson() => {
        'student_code': studentCode,
        'student_name': studentName,
        'academic_year': academicYear,
        'group_name': groupName,
      };
}