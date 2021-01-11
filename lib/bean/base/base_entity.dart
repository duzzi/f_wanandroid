



///1.生成entity对象
///2.添加part '文件名.g.dart';
///3.添加@JsonSerializable()
///4.按固定模式写
//   factory XXX.fromJson(Map<String, dynamic> json) => _$XXXFromJson(json);
//   Map<String,dynamic> toJson() => _$XXXToJson(this);
///5.flutter packages pub run build_runner build
class BaseEntity<T> {
  T data;
  int errorCode;
  String errorMsg;

  BaseEntity({this.data, this.errorCode, this.errorMsg});

}
