// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_type_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectTypeItem _$ProjectTypeItemFromJson(Map<String, dynamic> json) {
  return ProjectTypeItem(
    children: json['children'] as List,
    courseId: json['courseId'] as int,
    id: json['id'] as int,
    name: json['name'] as String,
    order: json['order'] as int,
    parentChapterId: json['parentChapterId'] as int,
    userControlSetTop: json['userControlSetTop'] as bool,
    visible: json['visible'] as int,
  );
}

Map<String, dynamic> _$ProjectTypeItemToJson(ProjectTypeItem instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
    };
