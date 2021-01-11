

import 'package:json_annotation/json_annotation.dart';

part 'knowledge_system_model.g.dart';

@JsonSerializable()
class KnowledgeSystemModel {
  List<KnowledgeSystemModel> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  KnowledgeSystemModel(
      {this.children,
        this.courseId,
        this.id,
        this.name,
        this.order,
        this.parentChapterId,
        this.userControlSetTop,
        this.visible});

  factory KnowledgeSystemModel.fromJson(Map<String, dynamic> json) =>
      _$KnowledgeSystemModelFromJson(json);

  Map<String, dynamic> toJson() => _$KnowledgeSystemModelToJson(this);

}


