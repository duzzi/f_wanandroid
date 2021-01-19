

import 'package:f_wan/bean/base/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'account_info.dart';

part 'account_info_response.g.dart';

@JsonSerializable()
class AccountInfoResponse extends BaseEntity<AccountInfo>{


  AccountInfoResponse();

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoResponseToJson(this);
}