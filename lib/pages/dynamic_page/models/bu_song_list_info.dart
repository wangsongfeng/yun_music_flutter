import 'package:json_annotation/json_annotation.dart';
part 'bu_song_list_info.g.dart';

@JsonSerializable()
class BuSongPlayListWarp extends Object {
  @JsonKey(name: 'result')
  List<BuSongListInfo>? result;
  @JsonKey(name: 'hasTaste')
  bool? hasTaste;
  @JsonKey(name: 'category')
  int? category;

  BuSongPlayListWarp(
    this.result,
    this.hasTaste,
    this.category,
  );
  factory BuSongPlayListWarp.fromJson(Map<String, dynamic> srcJson) =>
      _$BuSongPlayListWarpFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuSongPlayListWarpToJson(this);
}

@JsonSerializable()
class BuSongListInfo extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'copywriter')
  String? copywriter;
  @JsonKey(name: 'picUrl')
  String? picUrl;
  @JsonKey(name: 'canDislike')
  bool? canDislike;
  @JsonKey(name: 'trackNumberUpdateTime')
  int? trackNumberUpdateTime;
  @JsonKey(name: 'playCount')
  int? playCount;
  @JsonKey(name: 'trackCount')
  int? trackCount;
  @JsonKey(name: 'highQuality')
  bool? highQuality;
  @JsonKey(name: 'alg')
  String? alg;

  BuSongListInfo(
      {this.id,
      this.type,
      this.name,
      this.copywriter,
      this.picUrl,
      this.canDislike,
      this.trackNumberUpdateTime,
      this.playCount,
      this.trackCount,
      this.highQuality,
      this.alg});

  factory BuSongListInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$BuSongListInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuSongListInfoToJson(this);
}
