// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
  studentCode: json['student_code'] as String?,
  studentName: json['student_name'] as String?,
  studentPhone: json['student_phone'] as String?,
  parentPhone: json['parent_phone'] as String?,
  academicYear: json['academic_year'] as String?,
  paymentType: json['payment_type'] as String?,
  paymentTiming: json['payment_timing'] as String?,
  studentForm: json['student_form'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'student_code': instance.studentCode,
      'student_name': instance.studentName,
      'student_phone': instance.studentPhone,
      'parent_phone': instance.parentPhone,
      'academic_year': instance.academicYear,
      'payment_type': instance.paymentType,
      'payment_timing': instance.paymentTiming,
      'student_form': instance.studentForm,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
