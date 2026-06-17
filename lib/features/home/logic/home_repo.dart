import 'package:dio/dio.dart';
import 'package:super_system/core/network/api_error_model.dart';
import 'package:super_system/core/network/api_service.dart';
import 'package:super_system/features/home/model/home_response.dart';
import 'package:super_system/features/login/model/login_response_model.dart';

class HomeRepo {
  final ApiService _apiService;

  HomeRepo(this._apiService);

  Future<HomeResponse> getHomeStatistics(String token) async {
    try {
      final response = await _apiService.getHomeStatistics(token);
      return response;
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }

  Future<void> updateDevice({
    required String token,
    required String deviceName,
    required String appVersion,
    required String notificationsStatus,
  }) async {
    try {
      final formData = FormData.fromMap({
        'parent_token': token,
        'device_name': deviceName,
        'app_version': appVersion,
        'notifications_status': notificationsStatus,
      });
      await _apiService.updateDevice(formData);
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }

  Future<void> updateLastSeen(String token) async {
    try {
      final formData = FormData.fromMap({
        'parent_token': token,
      });
      await _apiService.updateLastSeen(formData);
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }

  Future<LoginResponseModel> updateParentToken(String refreshToken) async {
    try {
      final formData = FormData.fromMap({
        'refresh_token': refreshToken,
      });
      return await _apiService.updateParentToken(formData);
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }

  Future<void> updateFCM({required String token, required String fcmToken}) async {
    try {
      final formData = FormData.fromMap({
        'parent_token': token,
        'fcm_token': fcmToken,
      });
      await _apiService.updateFCM(formData);
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }
}
