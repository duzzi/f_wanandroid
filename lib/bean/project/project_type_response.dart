import 'package:f_wan/bean/base/base_entity.dart';
import 'package:f_wan/bean/project/project_type_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_type_response.g.dart';

@JsonSerializable()
class ProjectTypeResponse extends BaseEntity<List<ProjectTypeItem>> {
  ProjectTypeResponse();

  factory ProjectTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectTypeResponseToJson(this);
}
