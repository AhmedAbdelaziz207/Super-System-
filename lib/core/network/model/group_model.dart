import 'package:json_annotation/json_annotation.dart';
part 'group_model.g.dart';
@JsonSerializable(explicitToJson: true)
class GroupModel {
  @JsonKey(name: 'group_code')
  final String? groupCode;
  @JsonKey(name: 'group_name')
  final String? groupName;
  @JsonKey(name: 'academic_year')
  final String? academicYear;
  @JsonKey(name: 'monthly_payment')
  final String? monthlyPayment;

  GroupModel ({
    this.groupCode,
    this.groupName,
    this.academicYear,
    this.monthlyPayment,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);
  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}
