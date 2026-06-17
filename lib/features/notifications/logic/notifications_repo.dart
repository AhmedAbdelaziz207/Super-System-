import 'package:super_system/core/network/api_error_model.dart';
import 'package:super_system/core/network/api_service.dart';
import 'package:super_system/features/notifications/models/notifications_model.dart';

class NotificationsRepo {
  final ApiService _apiService;

  NotificationsRepo(this._apiService);

  Future<NotificationsModel> getNotifications(String token) async {
    try {
      final response = await _apiService.getNotifications(token);
      return response;
    } catch (error) {
      throw ApiErrorModel.getErrorMessage(error);
    }
  }
}
