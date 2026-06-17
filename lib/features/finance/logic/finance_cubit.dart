import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_system/core/utils/storage_service.dart';
import 'package:super_system/features/finance/logic/finance_repo.dart';
import 'package:super_system/features/finance/logic/finance_states.dart';

class FinanceCubit extends Cubit<FinanceStates> {
  final FinanceRepo _financeRepo;

  int selectedYear = DateTime.now().year;

  FinanceCubit(this._financeRepo) : super(FinanceInitial()) {
    // If the year is not 2026 (or subsequent/preceding years), default to 2026 for the mockup compatibility
    if (selectedYear < 2024 || selectedYear > 2028) {
      selectedYear = 2026;
    }
  }

  final List<int> availableYears = [2024, 2025, 2026, 2027, 2028];

  Future<void> getMonthlyExpenses({int? year}) async {
    if (year != null) {
      selectedYear = year;
    }
    if (isClosed) return;
    emit(FinanceLoading());
    try {
      final token = await StorageService().getSecure(StorageService.keyUserToken) ?? '';
      final response = await _financeRepo.getMonthlyExpenses(token: token, year: selectedYear);

      if (response.status == 'success') {
        emit(FinanceSuccess(data: response));
      } else {
        emit(FinanceFailure(message: 'فشل جلب السجلات المالية'));
      }
    } catch (e) {
      emit(FinanceFailure(message: e.toString()));
    }
  }

  void updateYearFilter(int year) {
    getMonthlyExpenses(year: year);
  }
}
