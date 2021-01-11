

import 'package:json_annotation/json_annotation.dart';


part 'banner_item.g.dart';

@JsonSerializable()
class BannerItem {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerItem(
      {this.desc,
        this.id,
        this.imagePath,
        this.isVisible,
        this.order,
        this.title,
        this.type,
        this.url});

  factory BannerItem.fromJson(Map<String, dynamic> json) => _$BannerItemFromJson(json);
  Map<String,dynamic> toJson() => _$BannerItemToJson(this);

}
