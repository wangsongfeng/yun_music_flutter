import 'package:json_annotation/json_annotation.dart';

part 'ranklist_item.g.dart';

@JsonSerializable()
class RanklistItem extends Object {
  @JsonKey(name: 'tracks')
  List<RankListTracks> tracks;

  @JsonKey(name: 'updateFrequency')
  String updateFrequency;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'subscribedCount')
  int subscribedCount;

  @JsonKey(name: 'coverImgUrl')
  String coverImgUrl;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updateTime')
  int updateTime;

  RanklistItem(
    this.tracks,
    this.updateFrequency,
    this.userId,
    this.subscribedCount,
    this.coverImgUrl,
    this.playCount,
    this.name,
    this.id,
    this.updateTime,
  );

  factory RanklistItem.fromJson(Map<String, dynamic> srcJson) =>
      _$RanklistItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RanklistItemToJson(this);
}

@JsonSerializable()
class RankListTracks extends Object {
  @JsonKey(name: 'first')
  String first;

  @JsonKey(name: 'second')
  String second;

  RankListTracks(
    this.first,
    this.second,
  );

  factory RankListTracks.fromJson(Map<String, dynamic> srcJson) =>
      _$RankListTracksFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RankListTracksToJson(this);
}
