import 'package:json_annotation/json_annotation.dart';
part 'teacher_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TeacherModel {
  @JsonKey(name: 'teacher_code')
  final String? teacherCode;
  @JsonKey(name: 'teacher_name')
  final String? teacherName;
  @JsonKey(name: 'teacher_phone')
  final String? teacherPhone;

  TeacherModel({this.teacherCode, this.teacherName, this.teacherPhone});

  factory TeacherModel.fromJson(Map<String, dynamic> json) => _$TeacherModelFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);
}
