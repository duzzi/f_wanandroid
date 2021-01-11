// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_url_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendUrlItem _$FriendUrlItemFromJson(Map<String, dynamic> json) {
  return FriendUrlItem(
    category: json['category'] as String,
    icon: json['icon'] as String,
    id: json['id'] as int,
    link: json['link'] as String,
    name: json['name'] as String,
    order: json['order'] as int,
    visible: json['visible'] as int,
  );
}

Map<String, dynamic> _$FriendUrlItemToJson(FriendUrlItem instance) =>
    <String, dynamic>{
      'category': instance.category,
      'icon': instance.icon,
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible,
    };
