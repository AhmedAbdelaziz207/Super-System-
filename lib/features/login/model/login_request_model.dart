// var data = FormData.fromMap({
//   'student_code': '100050',
//   'parent_password': 'MAA1009587',
//   'device_id': 'device-uuid-123',
//   'fcm_token': 'fcm-token-xyz',
//   'platform': 'android',
//   'device_name': 'Samsung Galaxy S21',
//   'app_version': '1.0.0',
//   'notifications_status': 'enabled',
//   'app': 'super',
// });


import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class LoginRequestModel {
  @JsonKey(name: 'student_code')
  String? studentCode;

  @JsonKey(name: 'parent_password')
  String? parentPassword;

  @JsonKey(name: 'device_id')
  String? deviceId;

  @JsonKey(name: 'fcm_token')
  String? fcmToken;

  @JsonKey(name: 'platform')
  String? platform;

  @JsonKey(name: 'device_name')
  String? deviceName;

  @JsonKey(name: 'app_version')
  String? appVersion;

  @JsonKey(name: 'notifications_status')
  String? notificationsStatus;

  @JsonKey(name: 'app')
  String? app;

  LoginRequestModel({
    this.studentCode,
    this.parentPassword,
    this.deviceId,
    this.fcmToken,
    this.platform,
    this.deviceName,
    this.appVersion,
    this.notificationsStatus,
    this.app,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
