// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_system_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeSystemResponse _$KnowledgeSystemResponseFromJson(
    Map<String, dynamic> json) {
  return KnowledgeSystemResponse()
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : KnowledgeSystemModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..errorCode = json['errorCode'] as int
    ..errorMsg = json['errorMsg'] as String;
}

Map<String, dynamic> _$KnowledgeSystemResponseToJson(
        KnowledgeSystemResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
