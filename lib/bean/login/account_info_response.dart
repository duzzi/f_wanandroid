

import 'package:appp/bean/base/base_entity.dart';
import 'package:appp/bean/login/account_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_info_response.g.dart';

@JsonSerializable()
class AccountInfoResponse extends BaseEntity<AccountInfo>{


  AccountInfoResponse();

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoResponseToJson(this);
}