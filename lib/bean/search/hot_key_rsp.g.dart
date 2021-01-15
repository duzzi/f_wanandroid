// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_key_rsp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotKeyRsp _$HotKeyRspFromJson(Map<String, dynamic> json) {
  return HotKeyRsp()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : HotKey.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..errorCode = json['errorCode'] as int
    ..errorMsg = json['errorMsg'] as String;
}

Map<String, dynamic> _$HotKeyRspToJson(HotKeyRsp instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
