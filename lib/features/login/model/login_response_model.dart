/*
{
    "status": "success",
    "message": "تم تسجيل الدخول بنجاح",
    "student": {
        "student_code": "STD-00001",
        "student_name": "محمد أحمد",
        "student_phone": "01012345678",
        "parent_phone": "01098765432",
        "academic_year": "third_secondary",
        "payment_type": "full",
        "payment_timing": "advance",
        "student_form": "abc123.pdf",
        "created_at": "2026-01-01 10:00:00",
        "updated_at": "2026-01-01 10:00:00"
    },
    "group": {
        "group_code": "GRP-00001",
        "group_name": "مجموعة الأحد",
        "academic_year": "third_secondary",
        "monthly_payment": "500"
    },
    "teacher": {
        "teacher_code": "TCH-AB12C",
        "teacher_name": "أحمد محمد علي",
        "teacher_phone": "01098765432"
    },
    "assistant": {
        "assistant_code": "AST-XY99Z",
        "assistant_name": "أبراهيم أحمد"
    },
    "parent_token": "tok_parent123",
    "refresh_token": "ref_parent789",
    "token_expiry": "2026-05-04 10:00:00",
    "refresh_token_expiry": "2026-05-19 10:00:00"
}
*/

import 'package:json_annotation/json_annotation.dart';
import 'package:super_system/core/network/model/assistant_model.dart';
import 'package:super_system/core/network/model/group_model.dart';
import 'package:super_system/core/network/model/student_model.dart';
import 'package:super_system/core/network/model/teacher_model.dart';
part 'login_response_model.g.dart';
@JsonSerializable(explicitToJson: true)
class LoginResponseModel {
  final String? status;
  final String? message;
  final StudentModel? student;
  final GroupModel? group;
  final TeacherModel? teacher;
  final AssistantModel? assistant;
  @JsonKey(name: 'parent_token')
  final String? parentToken;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'token_expiry')
  final String? tokenExpiry;
  @JsonKey(name: 'refresh_token_expiry')
  final String? refreshTokenExpiry;

  LoginResponseModel({
    this.status,
    this.message,
    this.student,
    this.group,
    this.teacher,
    this.assistant,
    this.parentToken,
    this.refreshToken,
    this.tokenExpiry,
    this.refreshTokenExpiry,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}


