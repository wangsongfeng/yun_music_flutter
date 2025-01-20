import 'package:json_annotation/json_annotation.dart';

part 'mine_music_list.g.dart';

@JsonSerializable()
class MineMusicList extends Object {
  @JsonKey(name: 'coverUrl')
  String? coverUrl;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'num')
  int? num;

  @JsonKey(name: 'desc')
  String? desc;

  MineMusicList(
    this.coverUrl,
    this.name,
    this.num,
    this.desc,
  );

  factory MineMusicList.fromJson(Map<String, dynamic> srcJson) =>
      _$MineMusicListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MineMusicListToJson(this);
}
