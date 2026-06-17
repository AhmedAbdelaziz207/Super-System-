class ApiEndpoints {
  const ApiEndpoints._();

  static const String baseUrl =
      'https://papayawhip-seahorse-130909.hostingersite.com';
  static const String login = '/parent/login';

  static const String home = '/parent/getStatistics';

  static const String notifications = '/parent/notifications/getNotifications';

  static const String attendence = '/parent/attendance/getAttendance';

  static const String examsResults = '/parent/exams/getExams';

  static const String getMonthlyExpenses =
      '/parent/monthly-expenses/getMonthlyExpenses';

  static const String getExecuse =
      '/parent/absence-requests/getAbsenceRequests';

  static const String fcmToken = '/parent/device/updateFCM';
  static const String updateDevice = "/parent/device/updateDevice";
  static const String updateLastSeen = "/parent/device/updateLastSeen";
  static const String updateParentToken = "/parent/account/updateParentToken";
}
