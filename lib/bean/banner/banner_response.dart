import 'banner_item.dart';
import 'package:f_wan/bean/base/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'banner_response.g.dart';

@JsonSerializable()
class Banners extends BaseEntity<List<BannerItem>> {




  factory Banners.fromJson(Map<String, dynamic> json) => _$BannersFromJson(json);
  Map<String,dynamic> toJson() => _$BannersToJson(this);

  Banners();
}
