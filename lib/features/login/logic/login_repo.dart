import 'package:dio/dio.dart';
import 'package:super_system/core/network/api_error_model.dart';
import 'package:super_system/core/network/api_service.dart';
import 'package:super_system/features/login/model/login_request_model.dart';
import 'package:super_system/features/login/model/login_response_model.dart';

class LoginRepo {
  final ApiService _apiService;

  LoginRepo(this._apiService);

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    try {
      final formData = FormData.fromMap(loginRequestModel.toJson());
      final response = await _apiService.login(formData);
      return response;
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }
}
