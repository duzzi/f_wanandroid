import 'package:f_wan/bean/article/article_tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_item.g.dart';

@JsonSerializable()
class ArticleItem {
  String apkLink;
  int audit;
  String author = "";
  bool canEdit;
  int chapterId;
  String chapterName = "";
  bool collect;
  int courseId;
  String desc;
  String descMd;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String niceShareDate;
  String origin;
  int originId;
  String prefix;
  String projectLink;
  int publishTime;
  int realSuperChapterId;
  int selfVisible;
  int shareDate;
  String shareUser = "";
  int superChapterId;
  String superChapterName = "";
  List<ArticleTag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  ArticleItem(
      {this.apkLink,
      this.audit,
      this.author,
      this.canEdit,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.descMd,
      this.envelopePic,
      this.fresh,
      this.id,
      this.link,
      this.niceDate,
      this.niceShareDate,
      this.origin,
      this.originId,
      this.prefix,
      this.projectLink,
      this.publishTime,
      this.realSuperChapterId,
      this.selfVisible,
      this.shareDate,
      this.shareUser,
      this.superChapterId,
      this.superChapterName,
      this.tags,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan});

  factory ArticleItem.fromJson(Map<String, dynamic> json) => _$ArticleItemFromJson(json);
  Map<String,dynamic> toJson() => _$ArticleItemToJson(this);
}
