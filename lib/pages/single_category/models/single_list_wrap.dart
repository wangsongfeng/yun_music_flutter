import 'package:json_annotation/json_annotation.dart';
part 'single_list_wrap.g.dart';

@JsonSerializable()
class SingleListWrap extends Object {
  List<Singles>? artists;

  SingleListWrap();

  factory SingleListWrap.fromJson(Map<String, dynamic> srcJson) =>
      _$SingleListWrapFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SingleListWrapToJson(this);
}

@JsonSerializable()
class Singles extends Object {
  int? id;
  int? accountId;

  String? name;

  String? picUrl;

  int? img1v1Id;
  String? img1v1Url;
  String? cover;

  int? albumSize;
  int? musicSize;
  int? mvSize;
  int? topicPerson;

  String? trans;
  String? briefDesc;

  bool? followed;

  int? publishTime;

  String? identityIconUrl;

  List<String>? alias;

  Singles();

  String getCoverUrl() {
    return img1v1Url ?? picUrl ?? "";
  }

  factory Singles.fromJson(Map<String, dynamic> srcJson) =>
      _$SinglesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SinglesToJson(this);
}
