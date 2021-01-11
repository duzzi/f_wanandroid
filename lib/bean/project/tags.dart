import 'package:json_annotation/json_annotation.dart';

part 'tags.g.dart';

@JsonSerializable()
class Tags {
  String name;
  String url;

  Tags({this.name, this.url});

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);
  Map<String,dynamic> toJson() => _$TagsToJson(this);
}
