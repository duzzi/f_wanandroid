import 'package:f_wan/bean/base/base_entity.dart';
import 'package:f_wan/bean/wechat/wechat_chapter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wechat_chapter_response.g.dart';

@JsonSerializable()
class WechatChapterResponse extends BaseEntity<List<WechatChapter>> {
  WechatChapterResponse();

  factory WechatChapterResponse.fromJson(Map<String, dynamic> json) =>
      _$WechatChapterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WechatChapterResponseToJson(this);
}
