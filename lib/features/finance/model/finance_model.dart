// {
//     "status": "success",
//     "filters": {
//         "year": 2026
//     },
//     "student": {
//         "student_code": "STD-00001",
//         "student_name": "محمد أحمد",
//         "academic_year": "third_secondary",
//         "academic_year_arabic": "الصف الثالث الثانوي",
//         "group_name": "مجموعة الأحد",
//         "payment_type": "full",
//         "payment_type_arabic": "كامل",
//         "payment_timing": "advance",
//         "payment_timing_arabic": "مقدم",
//         "current_monthly_payment": 500
//     },
//     "summary": {
//         "total_months": 5,
//         "total_paid": 4,
//         "total_not_paid": 1,
//         "total_paid_amount": 2000
//     },
//     "months": [
//         {
//             "month_number": 5,
//             "month_name": "مايو",
//             "year": 2026,
//             "full_label": "مايو 2026",
//             "is_current_month": true,
//             "payment_status": "not_paid",
//             "payment_details": null,
//             "expected_amount": {
//                 "full_payment": 500,
//                 "half_payment": 250
//             }
//         },
//         {
//             "month_number": 4,
//             "month_name": "أبريل",
//             "year": 2026,
//             "full_label": "أبريل 2026",
//             "is_current_month": false,
//             "payment_status": "paid",
//             "payment_details": {
//                 "expense_code": "EXP-00001",
//                 "payment_date": "2026-04-01",
//                 "payment_day_number": 3,
//                 "payment_day_name": "الأربعاء",
//                 "payment_month_number": 4,
//                 "payment_month_name": "أبريل",
//                 "payment_year": 2026,
//                 "paid_at": "2026-04-01 10:00:00",
//                 "updated_at": "2026-04-01 10:00:00",
//                 "monthly_payment_at_payment": 500,
//                 "payment_type_at_payment": "full",
//                 "payment_type_at_payment_arabic": "كامل",
//                 "group_code_at_payment": "GRP-00001",
//                 "group_name_at_payment": "مجموعة الأحد"
//             }
//         }
//     ]
// }

class FinanceModel {
  final String? status;
  final FinanceFilters? filters;
  final FinanceStudent? student;
  final FinanceSummary? summary;
  final List<FinanceMonth>? months;

  FinanceModel({
    this.status,
    this.filters,
    this.student,
    this.summary,
    this.months,
  });

  factory FinanceModel.fromJson(Map<String, dynamic> json) => FinanceModel(
        status: json['status'] as String?,
        filters: json['filters'] != null ? FinanceFilters.fromJson(json['filters']) : null,
        student: json['student'] != null ? FinanceStudent.fromJson(json['student']) : null,
        summary: json['summary'] != null ? FinanceSummary.fromJson(json['summary']) : null,
        months: json['months'] != null
            ? List<FinanceMonth>.from((json['months'] as List).map((x) => FinanceMonth.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'filters': filters?.toJson(),
        'student': student?.toJson(),
        'summary': summary?.toJson(),
        'months': months != null ? List<dynamic>.from(months!.map((x) => x.toJson())) : [],
      };

  factory FinanceModel.empty() => FinanceModel(
        status: '',
        filters: FinanceFilters.empty(),
        student: FinanceStudent.empty(),
        summary: FinanceSummary.empty(),
        months: [],
      );
}

class FinanceFilters {
  final int? year;

  FinanceFilters({this.year});

  factory FinanceFilters.fromJson(Map<String, dynamic> json) => FinanceFilters(
        year: json['year'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'year': year,
      };

  factory FinanceFilters.empty() => FinanceFilters(year: 0);
}

class FinanceStudent {
  final String? studentCode;
  final String? studentName;
  final String? academicYear;
  final String? academicYearArabic;
  final String? groupName;
  final String? paymentType;
  final String? paymentTypeArabic;
  final String? paymentTiming;
  final String? paymentTimingArabic;
  final int? currentMonthlyPayment;

  FinanceStudent({
    this.studentCode,
    this.studentName,
    this.academicYear,
    this.academicYearArabic,
    this.groupName,
    this.paymentType,
    this.paymentTypeArabic,
    this.paymentTiming,
    this.paymentTimingArabic,
    this.currentMonthlyPayment,
  });

  factory FinanceStudent.fromJson(Map<String, dynamic> json) => FinanceStudent(
        studentCode: json['student_code'] as String?,
        studentName: json['student_name'] as String?,
        academicYear: json['academic_year'] as String?,
        academicYearArabic: json['academic_year_arabic'] as String?,
        groupName: json['group_name'] as String?,
        paymentType: json['payment_type'] as String?,
        paymentTypeArabic: json['payment_type_arabic'] as String?,
        paymentTiming: json['payment_timing'] as String?,
        paymentTimingArabic: json['payment_timing_arabic'] as String?,
        currentMonthlyPayment: json['current_monthly_payment'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'student_code': studentCode,
        'student_name': studentName,
        'academic_year': academicYear,
        'academic_year_arabic': academicYearArabic,
        'group_name': groupName,
        'payment_type': paymentType,
        'payment_type_arabic': paymentTypeArabic,
        'payment_timing': paymentTiming,
        'payment_timing_arabic': paymentTimingArabic,
        'current_monthly_payment': currentMonthlyPayment,
      };

  factory FinanceStudent.empty() => FinanceStudent(
        studentCode: '',
        studentName: '',
        academicYear: '',
        academicYearArabic: '',
        groupName: '',
        paymentType: '',
        paymentTypeArabic: '',
        paymentTiming: '',
        paymentTimingArabic: '',
        currentMonthlyPayment: 0,
      );
}

class FinanceSummary {
  final int? totalMonths;
  final int? totalPaid;
  final int? totalNotPaid;
  final int? totalPaidAmount;

  FinanceSummary({
    this.totalMonths,
    this.totalPaid,
    this.totalNotPaid,
    this.totalPaidAmount,
  });

  factory FinanceSummary.fromJson(Map<String, dynamic> json) => FinanceSummary(
        totalMonths: json['total_months'] as int?,
        totalPaid: json['total_paid'] as int?,
        totalNotPaid: json['total_not_paid'] as int?,
        totalPaidAmount: json['total_paid_amount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'total_months': totalMonths,
        'total_paid': totalPaid,
        'total_not_paid': totalNotPaid,
        'total_paid_amount': totalPaidAmount,
      };

  factory FinanceSummary.empty() => FinanceSummary(
        totalMonths: 0,
        totalPaid: 0,
        totalNotPaid: 0,
        totalPaidAmount: 0,
      );
}

class FinanceMonth {
  final int? monthNumber;
  final String? monthName;
  final int? year;
  final String? fullLabel;
  final bool? isCurrentMonth;
  final String? paymentStatus;
  final PaymentDetails? paymentDetails;
  final ExpectedAmount? expectedAmount;

  FinanceMonth({
    this.monthNumber,
    this.monthName,
    this.year,
    this.fullLabel,
    this.isCurrentMonth,
    this.paymentStatus,
    this.paymentDetails,
    this.expectedAmount,
  });

  factory FinanceMonth.fromJson(Map<String, dynamic> json) => FinanceMonth(
        monthNumber: json['month_number'] as int?,
        monthName: json['month_name'] as String?,
        year: json['year'] as int?,
        fullLabel: json['full_label'] as String?,
        isCurrentMonth: json['is_current_month'] as bool?,
        paymentStatus: json['payment_status'] as String?,
        paymentDetails: json['payment_details'] != null
            ? PaymentDetails.fromJson(json['payment_details'])
            : null,
        expectedAmount: json['expected_amount'] != null
            ? ExpectedAmount.fromJson(json['expected_amount'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'month_number': monthNumber,
        'month_name': monthName,
        'year': year,
        'full_label': fullLabel,
        'is_current_month': isCurrentMonth,
        'payment_status': paymentStatus,
        'payment_details': paymentDetails?.toJson(),
        'expected_amount': expectedAmount?.toJson(),
      };
}

class PaymentDetails {
  final String? expenseCode;
  final String? paymentDate;
  final int? paymentDayNumber;
  final String? paymentDayName;
  final int? paymentMonthNumber;
  final String? paymentMonthName;
  final int? paymentYear;
  final String? paidAt;
  final String? updatedAt;
  final int? monthlyPaymentAtPayment;
  final String? paymentTypeAtPayment;
  final String? paymentTypeAtPaymentArabic;
  final String? groupCodeAtPayment;
  final String? groupNameAtPayment;

  PaymentDetails({
    this.expenseCode,
    this.paymentDate,
    this.paymentDayNumber,
    this.paymentDayName,
    this.paymentMonthNumber,
    this.paymentMonthName,
    this.paymentYear,
    this.paidAt,
    this.updatedAt,
    this.monthlyPaymentAtPayment,
    this.paymentTypeAtPayment,
    this.paymentTypeAtPaymentArabic,
    this.groupCodeAtPayment,
    this.groupNameAtPayment,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        expenseCode: json['expense_code'] as String?,
        paymentDate: json['payment_date'] as String?,
        paymentDayNumber: json['payment_day_number'] as int?,
        paymentDayName: json['payment_day_name'] as String?,
        paymentMonthNumber: json['payment_month_number'] as int?,
        paymentMonthName: json['payment_month_name'] as String?,
        paymentYear: json['payment_year'] as int?,
        paidAt: json['paid_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        monthlyPaymentAtPayment: json['monthly_payment_at_payment'] as int?,
        paymentTypeAtPayment: json['payment_type_at_payment'] as String?,
        paymentTypeAtPaymentArabic: json['payment_type_at_payment_arabic'] as String?,
        groupCodeAtPayment: json['group_code_at_payment'] as String?,
        groupNameAtPayment: json['group_name_at_payment'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'expense_code': expenseCode,
        'payment_date': paymentDate,
        'payment_day_number': paymentDayNumber,
        'payment_day_name': paymentDayName,
        'payment_month_number': paymentMonthNumber,
        'payment_month_name': paymentMonthName,
        'payment_year': paymentYear,
        'paid_at': paidAt,
        'updated_at': updatedAt,
        'monthly_payment_at_payment': monthlyPaymentAtPayment,
        'payment_type_at_payment': paymentTypeAtPayment,
        'payment_type_at_payment_arabic': paymentTypeAtPaymentArabic,
        'group_code_at_payment': groupCodeAtPayment,
        'group_name_at_payment': groupNameAtPayment,
      };
}

class ExpectedAmount {
  final int? fullPayment;
  final int? halfPayment;

  ExpectedAmount({
    this.fullPayment,
    this.halfPayment,
  });

  factory ExpectedAmount.fromJson(Map<String, dynamic> json) => ExpectedAmount(
        fullPayment: json['full_payment'] as int?,
        halfPayment: json['half_payment'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'full_payment': fullPayment,
        'half_payment': halfPayment,
      };
}