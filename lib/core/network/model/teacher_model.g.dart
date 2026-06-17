// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) => TeacherModel(
  teacherCode: json['teacher_code'] as String?,
  teacherName: json['teacher_name'] as String?,
  teacherPhone: json['teacher_phone'] as String?,
);

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      'teacher_code': instance.teacherCode,
      'teacher_name': instance.teacherName,
      'teacher_phone': instance.teacherPhone,
    };
