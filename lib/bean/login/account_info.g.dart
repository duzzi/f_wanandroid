// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) {
  return AccountInfo(
    admin: json['admin'] as bool,
    chapterTops: json['chapterTops'] as List,
    coinCount: json['coinCount'] as int,
    collectIds: json['collectIds'] as List,
    email: json['email'] as String,
    icon: json['icon'] as String,
    id: json['id'] as int,
    nickname: json['nickname'] as String,
    password: json['password'] as String,
    publicName: json['publicName'] as String,
    token: json['token'] as String,
    type: json['type'] as int,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$AccountInfoToJson(AccountInfo instance) =>
    <String, dynamic>{
      'admin': instance.admin,
      'chapterTops': instance.chapterTops,
      'coinCount': instance.coinCount,
      'collectIds': instance.collectIds,
      'email': instance.email,
      'icon': instance.icon,
      'id': instance.id,
      'nickname': instance.nickname,
      'password': instance.password,
      'publicName': instance.publicName,
      'token': instance.token,
      'type': instance.type,
      'username': instance.username,
    };
