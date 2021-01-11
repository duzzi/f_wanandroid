
import 'package:json_annotation/json_annotation.dart';


part 'project_type_item.g.dart';
@JsonSerializable()
class ProjectTypeItem {
  List<Object> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  ProjectTypeItem(
      {this.children,
        this.courseId,
        this.id,
        this.name,
        this.order,
        this.parentChapterId,
        this.userControlSetTop,
        this.visible});

  factory ProjectTypeItem.fromJson(Map<String, dynamic> json) => _$ProjectTypeItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectTypeItemToJson(this);
}
