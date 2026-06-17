import 'package:super_system/core/network/api_error_model.dart';
import 'package:super_system/core/network/api_service.dart';
import 'package:super_system/features/absences_requests/model/execuse_model.dart';

class AbsenceRequestRepo {
  final ApiService _apiService;

  AbsenceRequestRepo(this._apiService);

  Future<ExecuseModel> getAbsenceRequests({
    required String token,
    required int month,
    required int year,
  }) async {
    try {
      return await _apiService.getAbsenceRequests(token, month, year);
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }
}
