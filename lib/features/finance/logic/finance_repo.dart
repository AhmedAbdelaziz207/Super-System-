import 'package:super_system/core/network/api_error_model.dart';
import 'package:super_system/core/network/api_service.dart';
import 'package:super_system/features/finance/model/finance_model.dart';

class FinanceRepo {
  final ApiService _apiService;

  FinanceRepo(this._apiService);

  Future<FinanceModel> getMonthlyExpenses({
    required String token,
    required int year,
  }) async {
    try {
      final response = await _apiService.getMonthlyExpenses(token,year );
      return response;
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }
}
