import 'package:json_annotation/json_annotation.dart';

part 'hot_key.g.dart';

@JsonSerializable()
class HotKey {
  int id;
  String link;
  String name;
  int order;
  int visible;

  HotKey({this.id, this.link, this.name, this.order, this.visible});

  factory HotKey.fromJson(Map<String, dynamic> json) => _$HotKeyFromJson(json);

  Map<String, dynamic> toJson() => _$HotKeyToJson(this);
}
