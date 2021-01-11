
import 'package:json_annotation/json_annotation.dart';

part 'article_tag.g.dart';

@JsonSerializable()
class ArticleTag {
  String name;
  String url;

  ArticleTag({this.name, this.url});

  factory ArticleTag.fromJson(Map<String, dynamic> json) => _$ArticleTagFromJson(json);
  Map<String,dynamic> toJson() => _$ArticleTagToJson(this);
  
}
