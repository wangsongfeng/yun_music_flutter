import 'package:json_annotation/json_annotation.dart';

part 'hishort_info.g.dart';

@JsonSerializable()
class HishortInfo extends Object {
  @JsonKey(name: "collectNums")
  int? collectNums;
  @JsonKey(name: "likeNums")
  int? likeNums;
  @JsonKey(name: "vidName")
  String? vidName;
  @JsonKey(name: "payNVideo")
  int? payNVideo;
  @JsonKey(name: "isCollect")
  int? isCollect;
  @JsonKey(name: "consumeCoin")
  int? consumeCoin;
  @JsonKey(name: "firstPlayId")
  int? firstPlayId;
  @JsonKey(name: "coverUrl")
  String? coverUrl;
  @JsonKey(name: "totalNum")
  int? totalNum;
  @JsonKey(name: "isLike")
  int? isLike;
  @JsonKey(name: "firstPlayUrl")
  String? firstPlayUrl;
  @JsonKey(name: "cpId")
  int? cpId;
  @JsonKey(name: "vidId")
  int? vidId;
  @JsonKey(name: "vidDescribe")
  String? vidDescribe;

  HishortInfo(
    this.collectNums,
    this.likeNums,
    this.vidName,
    this.payNVideo,
    this.isCollect,
    this.consumeCoin,
    this.firstPlayId,
    this.coverUrl,
    this.totalNum,
    this.isLike,
    this.firstPlayUrl,
    this.cpId,
    this.vidId,
    this.vidDescribe,
  );

  factory HishortInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$HishortInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HishortInfoToJson(this);
}
