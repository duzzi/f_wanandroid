// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wechat_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WechatChapter _$WechatChapterFromJson(Map<String, dynamic> json) {
  return WechatChapter(
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

Map<String, dynamic> _$WechatChapterToJson(WechatChapter instance) =>
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
