import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';
@JsonSerializable(explicitToJson: true)
class StudentModel {
  @JsonKey(name: 'student_code')
  final String? studentCode;
  @JsonKey(name: 'student_name')
  final String? studentName;
  @JsonKey(name: 'student_phone')
  final String? studentPhone;
  @JsonKey(name: 'parent_phone')
  final String? parentPhone;
  @JsonKey(name: 'academic_year')
  final String? academicYear;
  @JsonKey(name: 'payment_type')
  final String? paymentType;
  @JsonKey(name: 'payment_timing')
  final String? paymentTiming;
  @JsonKey(name: 'student_form')
  final String? studentForm;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  StudentModel({
    this.studentCode,
    this.studentName,
    this.studentPhone,
    this.parentPhone,
    this.academicYear,
    this.paymentType,
    this.paymentTiming,
    this.studentForm,
    this.createdAt,
    this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
