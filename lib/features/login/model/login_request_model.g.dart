// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    LoginRequestModel(
      studentCode: json['student_code'] as String?,
      parentPassword: json['parent_password'] as String?,
      deviceId: json['device_id'] as String?,
      fcmToken: json['fcm_token'] as String?,
      platform: json['platform'] as String?,
      deviceName: json['device_name'] as String?,
      appVersion: json['app_version'] as String?,
      notificationsStatus: json['notifications_status'] as String?,
      app: json['app'] as String?,
    );

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      if (instance.studentCode case final value?) 'student_code': value,
      if (instance.parentPassword case final value?) 'parent_password': value,
      if (instance.deviceId case final value?) 'device_id': value,
      if (instance.fcmToken case final value?) 'fcm_token': value,
      if (instance.platform case final value?) 'platform': value,
      if (instance.deviceName case final value?) 'device_name': value,
      if (instance.appVersion case final value?) 'app_version': value,
      if (instance.notificationsStatus case final value?)
        'notifications_status': value,
      if (instance.app case final value?) 'app': value,
    };
