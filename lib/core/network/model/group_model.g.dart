// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
  groupCode: json['group_code'] as String?,
  groupName: json['group_name'] as String?,
  academicYear: json['academic_year'] as String?,
  monthlyPayment: json['monthly_payment'] as String?,
);

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      'group_code': instance.groupCode,
      'group_name': instance.groupName,
      'academic_year': instance.academicYear,
      'monthly_payment': instance.monthlyPayment,
    };
