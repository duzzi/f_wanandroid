import 'package:json_annotation/json_annotation.dart';

part 'wechat_chapter.g.dart';

@JsonSerializable()
class WechatChapter {
  List<Object> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  WechatChapter(
      {this.children,
      this.courseId,
      this.id,
      this.name,
      this.order,
      this.parentChapterId,
      this.userControlSetTop,
      this.visible});

  factory WechatChapter.fromJson(Map<String, dynamic> json) => _$WechatChapterFromJson(json);

  Map<String, dynamic> toJson() => _$WechatChapterToJson(this);
}
