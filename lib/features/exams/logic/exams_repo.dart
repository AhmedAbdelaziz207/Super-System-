import 'package:super_system/core/network/api_error_model.dart';
import 'package:super_system/core/network/api_service.dart';
import 'package:super_system/features/exams/model/exams_results_model.dart';

class ExamsRepo {
  final ApiService _apiService;

  ExamsRepo(this._apiService);

  Future<ExamsResultsModel> getExamsResults(String token) async {
    try {
      final response = await _apiService.getExamsResults(token);
      return response;
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }
}
