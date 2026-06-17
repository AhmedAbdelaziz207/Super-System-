import 'package:json_annotation/json_annotation.dart';
part 'assistant_model.g.dart';
@JsonSerializable(explicitToJson: true)
class AssistantModel {
  @JsonKey(name: 'assistant_code')
  final String? assistantCode;
  @JsonKey(name: 'assistant_name')
  final String? assistantName;

  AssistantModel({this.assistantCode, this.assistantName});

  factory AssistantModel.fromJson(Map<String, dynamic> json) =>
      _$AssistantModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssistantModelToJson(this);
}
