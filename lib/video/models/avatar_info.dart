import 'package:json_annotation/json_annotation.dart';

part 'avatar_info.g.dart';

@JsonSerializable()
class AvatarInfo extends Object {
  @JsonKey(name: 'avatar_168x168')
  AvatarUrlsInfo? avatar_168x168;

  @JsonKey(name: 'avatar_300x300')
  AvatarUrlsInfo? avatar_300x300;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'uid')
  String? uid;

  @JsonKey(name: 'nickname')
  String? nickname;

  AvatarInfo(
    this.avatar_168x168,
    this.avatar_300x300,
    this.city,
    this.uid,
    this.nickname,
  );

  factory AvatarInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$AvatarInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AvatarInfoToJson(this);
}

@JsonSerializable()
class AvatarUrlsInfo extends Object {
  @JsonKey(name: 'height')
  int? height;
  @JsonKey(name: 'width')
  int? width;
  @JsonKey(name: 'url_list')
  List<String>? url_list;
  @JsonKey(name: 'uri')
  String? uri;

  AvatarUrlsInfo(
    this.width,
    this.height,
    this.url_list,
    this.uri,
  );

  factory AvatarUrlsInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$AvatarUrlsInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AvatarUrlsInfoToJson(this);
}
