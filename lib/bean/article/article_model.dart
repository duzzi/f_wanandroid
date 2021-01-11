import 'package:json_annotation/json_annotation.dart';

import 'article_item.dart';
part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  int curPage;
  List<ArticleItem> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  ArticleModel(
      {this.curPage, this.datas, this.offset, this.over, this.pageCount, this.size, this.total});

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);
  Map<String,dynamic> toJson() => _$ArticleModelToJson(this);
}
