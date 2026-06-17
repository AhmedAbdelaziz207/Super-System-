// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      student:
          json['student'] == null
              ? null
              : StudentModel.fromJson(json['student'] as Map<String, dynamic>),
      group:
          json['group'] == null
              ? null
              : GroupModel.fromJson(json['group'] as Map<String, dynamic>),
      teacher:
          json['teacher'] == null
              ? null
              : TeacherModel.fromJson(json['teacher'] as Map<String, dynamic>),
      assistant:
          json['assistant'] == null
              ? null
              : AssistantModel.fromJson(
                json['assistant'] as Map<String, dynamic>,
              ),
      parentToken: json['parent_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      tokenExpiry: json['token_expiry'] as String?,
      refreshTokenExpiry: json['refresh_token_expiry'] as String?,
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'student': instance.student?.toJson(),
      'group': instance.group?.toJson(),
      'teacher': instance.teacher?.toJson(),
      'assistant': instance.assistant?.toJson(),
      'parent_token': instance.parentToken,
      'refresh_token': instance.refreshToken,
      'token_expiry': instance.tokenExpiry,
      'refresh_token_expiry': instance.refreshTokenExpiry,
    };
