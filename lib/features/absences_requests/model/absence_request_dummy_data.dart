import 'package:super_system/features/absences_requests/model/execuse_model.dart';

/// Set to true only for local UI testing when the API returns [].
const bool kUseDummyAbsenceRequestsWhenEmpty = false;

class AbsenceRequestDummyData {
  AbsenceRequestDummyData._();

  static List<ExecuseRequest> get requests => [
        ExecuseRequest(
          requestCode: 'REQ-00042',
          requestedBy: 'parent',
          reason: 'ظروف عائلية طارئة',
          totalAbsenceDates: 3,
          absenceDates: [
            ExecuseAbsenceDate(
              absenceDate: '2026-04-20',
              dayNumber: 4,
              dayName: 'الخميس',
              monthNumber: 4,
              monthName: 'أبريل',
              year: 2026,
            ),
          ],
          submittedBy: ExecuseSubmittedBy(
            assistantCode: 'AST-XY99Z',
            assistantName: 'إبراهيم أحمد',
          ),
          submittedAt: ExecuseSubmittedAt(
            datetime: _hoursAgo(2),
            dayNumber: 3,
            dayName: 'الأربعاء',
            monthNumber: 4,
            monthName: 'أبريل',
            year: 2026,
          ),
          updatedAt: '2026-04-29 09:15:00',
        ),
        ExecuseRequest(
          requestCode: 'REQ-00041',
          requestedBy: 'parent',
          reason: 'استئذان طبي',
          totalAbsenceDates: 1,
          absenceDates: [
            ExecuseAbsenceDate(
              absenceDate: '2026-04-18',
              dayNumber: 2,
              dayName: 'الثلاثاء',
              monthNumber: 4,
              monthName: 'أبريل',
              year: 2026,
            ),
          ],
          submittedBy: ExecuseSubmittedBy(
            assistantCode: 'AST-AB12C',
            assistantName: 'محمد عبدالله',
          ),
          submittedAt: ExecuseSubmittedAt(
            datetime: _daysAgo(1),
            dayNumber: 2,
            dayName: 'الثلاثاء',
            monthNumber: 4,
            monthName: 'أبريل',
            year: 2026,
          ),
          updatedAt: '2026-04-28 14:00:00',
        ),
        ExecuseRequest(
          requestCode: 'REQ-00040',
          requestedBy: 'parent',
          reason: 'مناسبة عائلية',
          totalAbsenceDates: 2,
          absenceDates: [
            ExecuseAbsenceDate(
              absenceDate: '2026-04-15',
              dayNumber: 6,
              dayName: 'السبت',
              monthNumber: 4,
              monthName: 'أبريل',
              year: 2026,
            ),
            ExecuseAbsenceDate(
              absenceDate: '2026-04-16',
              dayNumber: 0,
              dayName: 'الأحد',
              monthNumber: 4,
              monthName: 'أبريل',
              year: 2026,
            ),
          ],
          submittedBy: ExecuseSubmittedBy(
            assistantCode: 'AST-CD34D',
            assistantName: 'أحمد محمود',
          ),
          submittedAt: ExecuseSubmittedAt(
            datetime: _daysAgo(3),
            dayNumber: 0,
            dayName: 'الأحد',
            monthNumber: 4,
            monthName: 'أبريل',
            year: 2026,
          ),
          updatedAt: '2026-04-27 10:30:00',
        ),
      ];

  static String _hoursAgo(int hours) {
    final dt = DateTime.now().subtract(Duration(hours: hours));
    return '${dt.year}-${_two(dt.month)}-${_two(dt.day)} ${_two(dt.hour)}:${_two(dt.minute)}:00';
  }

  static String _daysAgo(int days) {
    final dt = DateTime.now().subtract(Duration(days: days));
    return '${dt.year}-${_two(dt.month)}-${_two(dt.day)} ${_two(dt.hour)}:${_two(dt.minute)}:00';
  }

  static String _two(int n) => n.toString().padLeft(2, '0');

  static ExecuseModel applyIfEmpty(ExecuseModel model) {
    if (!kUseDummyAbsenceRequestsWhenEmpty || model.requests.isNotEmpty) {
      return model;
    }

    final dummy = requests;
    final excusedDays = dummy.fold<int>(
      0,
      (sum, r) => sum + (r.totalAbsenceDates ?? r.absenceDates.length),
    );

    return ExecuseModel(
      status: model.status,
      filters: model.filters,
      student: model.student,
      summary: ExecuseSummary(
        totalRequests: dummy.length,
        totalExcusedDays: excusedDays,
      ),
      requests: dummy,
    );
  }
}
