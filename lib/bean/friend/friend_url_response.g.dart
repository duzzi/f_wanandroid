// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_url_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendUrlResponse _$FriendUrlResponseFromJson(Map<String, dynamic> json) {
  return FriendUrlResponse()
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : FriendUrlItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..errorCode = json['errorCode'] as int
    ..errorMsg = json['errorMsg'] as String;
}

Map<String, dynamic> _$FriendUrlResponseToJson(FriendUrlResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
