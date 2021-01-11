// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectTypeResponse _$ProjectTypeResponseFromJson(Map<String, dynamic> json) {
  return ProjectTypeResponse()
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ProjectTypeItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..errorCode = json['errorCode'] as int
    ..errorMsg = json['errorMsg'] as String;
}

Map<String, dynamic> _$ProjectTypeResponseToJson(
        ProjectTypeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
