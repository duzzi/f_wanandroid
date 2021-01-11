import 'package:appp/bean/base/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'article_model.dart';
part 'article_response.g.dart';

@JsonSerializable()
class ArticleResponse extends BaseEntity<ArticleModel> {
  factory ArticleResponse.fromJson(Map<String, dynamic> json) => _$ArticleResponseFromJson(json);
  Map<String,dynamic> toJson() => _$ArticleResponseToJson(this);

  ArticleResponse();
}
