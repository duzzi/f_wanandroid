import 'package:appp/bean/base/base_entity.dart';
import 'package:appp/bean/knowledge/knowledge_system_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'knowledge_system_response.g.dart';

@JsonSerializable()
class KnowledgeSystemResponse extends BaseEntity<List<KnowledgeSystemModel>> {
  KnowledgeSystemResponse();

  factory KnowledgeSystemResponse.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeSystemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KnowledgeSystemResponseToJson(this);
}
