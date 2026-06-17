// {
//     "status": "success",
//     "filter": "all",
//     "student": {
//         "student_code": "STD-00001",
//         "student_name": "محمد أحمد",
//         "academic_year": "third_secondary",
//         "academic_year_arabic": "الصف الثالث الثانوي",
//         "group_name": "مجموعة الأحد"
//     },
//     "summary": {
//         "total_exams": 2,
//         "total_attended": 1,
//         "total_absent": 1
//     },
//     "total_returned": 2,
//     "exams": [
//         {
//             "exam_code": "EXM-00001",
//             "exam_name": "امتحان الفيزياء",
//             "academic_year": "third_secondary",
//             "academic_year_arabic": "الصف الثالث الثانوي",
//             "scope": "all",
//             "total_grade": 100,
//             "student_result": {
//                 "attended": true,
//                 "grade": 92,
//                 "percentage": "92%",
//                 "pass_status": "ناجح"
//             },
//             "exam_stats": {
//                 "total_sat": 25,
//                 "total_passed": 20,
//                 "success_rate": "80%"
//             },
//             "created_at": "2026-04-28 12:00:00",
//             "updated_at": "2026-04-28 14:00:00"
//         },
//         {
//             "exam_code": "EXM-00002",
//             "exam_name": "امتحان الكيمياء",
//             "academic_year": "third_secondary",
//             "academic_year_arabic": "الصف الثالث الثانوي",
//             "scope": "specific",
//             "total_grade": 50,
//             "student_result": {
//                 "attended": false,
//                 "grade": null,
//                 "percentage": null,
//                 "pass_status": null
//             },
//             "exam_stats": {
//                 "total_sat": 18,
//                 "total_passed": 15,
//                 "success_rate": "83.33%"
//             },
//             "created_at": "2026-04-20 12:00:00",
//             "updated_at": "2026-04-20 12:00:00"
//         }
//     ]
// }
// add null safety




class ExamsResultsModel {
   final String status;
   final String filter;
   final StudentModel student;
   final SummaryModel summary;
   final int totalReturned;
   final List<ExamModel> exams;

   ExamsResultsModel({
    required this.status,
    required this.filter,
    required this.student,
    required this.summary,
    required this.totalReturned,
    required this.exams,
   });
   factory ExamsResultsModel.fromJson(Map<String, dynamic> json) => ExamsResultsModel(
    status: json['status'] as String? ?? '',
    filter: json['filter'] as String? ?? '',
    student: json['student'] != null ? StudentModel.fromJson(json['student']) : StudentModel(),
    summary: json['summary'] != null ? SummaryModel.fromJson(json['summary']) : SummaryModel(),
    totalReturned: json['total_returned'] as int? ?? 0,
    exams: json['exams'] != null 
        ? List<ExamModel>.from((json['exams'] as List).map((x) => ExamModel.fromJson(x)))
        : [],
   );

   


   
}


class StudentModel {
  final String? studentCode;
  final String? studentName;
  final String? academicYear;
  final String? academicYearArabic;
  final String? groupName;

  StudentModel({
    this.studentCode,
    this.studentName,
    this.academicYear,
    this.academicYearArabic,
    this.groupName,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    studentCode: json['student_code'],
    studentName: json['student_name'],
    academicYear: json['academic_year'],
    academicYearArabic: json['academic_year_arabic'],
    groupName: json['group_name'],
  );
}

class SummaryModel {
  final int? totalExams;
  final int? totalAttended;
  final int? totalAbsent;

  SummaryModel({
    this.totalExams,
    this.totalAttended,
    this.totalAbsent,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
    totalExams: json['total_exams'],
    totalAttended: json['total_attended'],
    totalAbsent: json['total_absent'],
  );
}

class ExamModel {
  final String? examCode;
  final String? examName;
  final String? academicYear;
  final String? academicYearArabic;
  final String? scope;
  final int? totalGrade;
  final StudentResult? studentResult;
  final ExamStats? examStats;
  final String? createdAt;
  final String? updatedAt;

  ExamModel({
    this.examCode,
    this.examName,
    this.academicYear,
    this.academicYearArabic,
    this.scope,
    this.totalGrade,
    this.studentResult,
    this.examStats,
    this.createdAt,
    this.updatedAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
    examCode: json['exam_code'] as String?,
    examName: json['exam_name'] as String?,
    academicYear: json['academic_year'] as String?,
    academicYearArabic: json['academic_year_arabic'] as String?,
    scope: json['scope'] as String?,
    totalGrade: json['total_grade'] as int?,
    studentResult: json['student_result'] != null 
        ? StudentResult.fromJson(json['student_result']) 
        : null,
    examStats: json['exam_stats'] != null 
        ? ExamStats.fromJson(json['exam_stats']) 
        : null,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
  );


  Map<String, dynamic> toJson() => {
    'exam_code': examCode,
    'exam_name': examName,
    'academic_year': academicYear,
    'academic_year_arabic': academicYearArabic,
    'scope': scope,
    'total_grade': totalGrade,
    'student_result': studentResult?.toJson(),
    'exam_stats': examStats?.toJson(),
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class StudentResult {
  final bool? attended;
  final int? grade;
  final String? percentage;
  final String? passStatus;

  StudentResult({
    this.attended,
    this.grade,
    this.percentage,
    this.passStatus,
  });

  factory StudentResult.fromJson(Map<String, dynamic> json) => StudentResult(
    attended: json['attended'] as bool?,
    grade: json['grade'] as int?,
    percentage: json['percentage'] as String?,
    passStatus: json['pass_status'] as String?,
  );


  Map<String, dynamic> toJson() => {
    'attended': attended,
    'grade': grade,
    'percentage': percentage,
    'pass_status': passStatus,
  };
}

class ExamStats {
  final int? totalSat;
  final int? totalPassed;
  final String? successRate;

  ExamStats({
    this.totalSat,
    this.totalPassed,
    this.successRate,
  });

  factory ExamStats.fromJson(Map<String, dynamic> json) => ExamStats(
    totalSat: json['total_sat'] as int?,
    totalPassed: json['total_passed'] as int?,
    successRate: json['success_rate'] as String?,
  );


  Map<String, dynamic> toJson() => {
    'total_sat': totalSat,
    'total_passed': totalPassed,
    'success_rate': successRate,
  };
}
