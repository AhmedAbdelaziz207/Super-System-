import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/features/absences_requests/logic/absence_request_repo.dart';
import 'package:super_system/features/absences_requests/logic/absence_request_states.dart';
class AbsenceRequestCubit extends Cubit<AbsenceRequestStates> {
  final AbsenceRequestRepo _repo;

  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  AbsenceRequestCubit(this._repo) : super(AbsenceRequestInitial());

  Future<void> getAbsenceRequests({int? month, int? year}) async {
    if (month != null) selectedMonth = month;
    if (year != null) selectedYear = year;

    if (isClosed) return;
    emit(AbsenceRequestLoading());

    try {
      final token = await StorageService().getSecure(StorageService.keyUserToken) ?? '';
      final response = await _repo.getAbsenceRequests(
        token: token,
        month: selectedMonth,
        year: selectedYear,
      );

      if (response.status == 'success') {
        emit(AbsenceRequestSuccess(response));
      } else {
        emit(AbsenceRequestFailure('فشل جلب طلبات الغياب'));
      }
    } catch (e) {
      emit(AbsenceRequestFailure(e.toString()));
    }
  }

  void updateFilters(int month, int year) {
    selectedMonth = month;
    selectedYear = year;
    getAbsenceRequests();
  }
}
