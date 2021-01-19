import 'package:f_wan/bean/base/base_entity.dart';
import 'package:f_wan/bean/search/hot_key.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hot_key_rsp.g.dart';

@JsonSerializable()
class HotKeyRsp extends BaseEntity<List<HotKey>> {
  HotKeyRsp();

  factory HotKeyRsp.fromJson(Map<String, dynamic> json) =>
      _$HotKeyRspFromJson(json);

  Map<String, dynamic> toJson() => _$HotKeyRspToJson(this);
}
