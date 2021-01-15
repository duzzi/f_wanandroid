// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotKey _$HotKeyFromJson(Map<String, dynamic> json) {
  return HotKey(
    id: json['id'] as int,
    link: json['link'] as String,
    name: json['name'] as String,
    order: json['order'] as int,
    visible: json['visible'] as int,
  );
}

Map<String, dynamic> _$HotKeyToJson(HotKey instance) => <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible,
    };
