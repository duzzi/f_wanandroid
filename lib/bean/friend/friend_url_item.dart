import 'package:json_annotation/json_annotation.dart';

part 'friend_url_item.g.dart';

@JsonSerializable()
class FriendUrlItem {
  String category;
  String icon;
  int id;
  String link;
  String name;
  int order;
  int visible;

  FriendUrlItem(
      {this.category, this.icon, this.id, this.link, this.name, this.order, this.visible});


  factory FriendUrlItem.fromJson(Map<String, dynamic> json) =>
      _$FriendUrlItemFromJson(json);

  Map<String, dynamic> toJson() => _$FriendUrlItemToJson(this);
}
