import 'package:json_annotation/json_annotation.dart';
part 'hankan_info.g.dart';

@JsonSerializable()
class HankanInfo extends Object {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "poster")
  String? poster;
  @JsonKey(name: "poster_small")
  String? poster_small;
  @JsonKey(name: "poster_big")
  String? poster_big;
  @JsonKey(name: "poster_pc")
  String? poster_pc;
  @JsonKey(name: "source_name")
  String? source_name;
  @JsonKey(name: "play_url")
  String? play_url;
  @JsonKey(name: "playcnt")
  int? playcnt;
  @JsonKey(name: "mthid")
  String? mthid;
  @JsonKey(name: "mthpic")
  String? mthpic;
  @JsonKey(name: "threadId")
  String? threadId;
  @JsonKey(name: "site_name")
  String? site_name;
  @JsonKey(name: "duration")
  String? duration;
  @JsonKey(name: "like")
  int? like;
  @JsonKey(name: "comment")
  String? comment;

  HankanInfo(
      {this.id,
      this.title,
      this.poster,
      this.poster_small,
      this.poster_big,
      this.poster_pc,
      this.source_name,
      this.play_url,
      this.playcnt,
      this.mthid,
      this.mthpic,
      this.threadId,
      this.site_name,
      this.duration,
      this.like,
      this.comment});

  factory HankanInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$HankanInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HankanInfoToJson(this);
}
