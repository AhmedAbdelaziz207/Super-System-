import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/features/attendence/logic/attendence_repo.dart';
import 'package:super_system/features/attendence/logic/attendence_states.dart';

class AttendenceCubit extends Cubit<AttendenceStates> {
  final AttendenceRepo _attendenceRepo;

  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  AttendenceCubit(this._attendenceRepo) : super(AttendenceInitial());

  Future<void> getAttendance({int? month, int? year}) async {
    if (month != null) selectedMonth = month;
    if (year != null) selectedYear = year;

    if (isClosed) return;
    emit(AttendenceLoading());
    try {
      final token =
          await StorageService().getSecure(StorageService.keyUserToken) ?? '';
      final response = await _attendenceRepo.getAttendance(
        token: token,
        month: selectedMonth,
        year: selectedYear,
      );

      if (response.status == 'success') {
        emit(AttendenceSuccess(data: response));
      } else {
        emit(AttendenceFailure(message: 'فشل جلب سجل الغياب'));
      }
    } catch (e) {
      emit(AttendenceFailure(message: e.toString()));
    }
  }

  void updateFilters(int month, int year) {
    selectedMonth = month;
    selectedYear = year;
    getAttendance();
  }
}
