// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wechat_chapter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WechatChapterResponse _$WechatChapterResponseFromJson(
    Map<String, dynamic> json) {
  return WechatChapterResponse()
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : WechatChapter.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..errorCode = json['errorCode'] as int
    ..errorMsg = json['errorMsg'] as String;
}

Map<String, dynamic> _$WechatChapterResponseToJson(
        WechatChapterResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
