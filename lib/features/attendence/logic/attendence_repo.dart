import 'package:super_system/core/network/api_error_model.dart';
import 'package:super_system/core/network/api_service.dart';
import 'package:super_system/features/attendence/model/attendence_model.dart';

class AttendenceRepo {
  final ApiService _apiService;

  AttendenceRepo(this._apiService);

  Future<AttendenceModel> getAttendance({
    required String token,
    required int month,
    required int year,
  }) async {
    try {
      final response = await _apiService.getAttendence(token, month, year,'absence');
      return response;
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }
}
