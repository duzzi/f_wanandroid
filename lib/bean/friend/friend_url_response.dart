import 'package:appp/bean/base/base_entity.dart';
import 'package:appp/bean/friend/friend_url_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_url_response.g.dart';

@JsonSerializable()
class FriendUrlResponse extends BaseEntity<List<FriendUrlItem>> {
  factory FriendUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendUrlResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FriendUrlResponseToJson(this);

  FriendUrlResponse();
}
