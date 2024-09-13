import 'package:json_annotation/json_annotation.dart';
import 'package:yun_music/commons/models/search_video_model.dart';

part 'video_group.g.dart';

@JsonSerializable()
class VideoGroupSourceList extends Object {
  VideoGroupSourceList();

  String? msg;
  int? code;
  bool? hasmore;
  int? rcmdLimit;
  List<VideoSurceItem>? datas;

  factory VideoGroupSourceList.fromJson(Map<String, dynamic> json) =>
      _$VideoGroupSourceListFromJson(json);

  toJson() => _$VideoGroupSourceListToJson(this);
}

@JsonSerializable()
class VideoSurceItem {
  int? type;
  VideoGroupData? data;

  VideoSurceItem();
  factory VideoSurceItem.fromJson(Map<String, dynamic> json) =>
      _$VideoSurceItemFromJson(json);

  toJson() => _$VideoSurceItemToJson(this);
}

@JsonSerializable()
class VideoGroupData {
  String? coverUrl;
  double? height;
  double? width;
  String? title;
  String? description;
  int? commentCount;
  int? shareCount;
  int? praisedCount;
  int? playTime;
  Creator? creator;
  String? previewUrl;
  String? vid;
  List<ResolutionsItem>? resolutions;
  List<VideoGroupItem>? videoGroup;

  VideoGroupData();

  factory VideoGroupData.fromJson(Map<String, dynamic> json) =>
      _$VideoGroupDataFromJson(json);

  toJson() => _$VideoGroupDataToJson(this);
}

@JsonSerializable()
class ResolutionsItem {
  ResolutionsItem();

  int? size;
  int? resolution;

  factory ResolutionsItem.fromJson(Map<String, dynamic> json) =>
      _$ResolutionsItemFromJson(json);

  toJson() => _$ResolutionsItemToJson(this);
}

@JsonSerializable()
class VideoGroupItem {
  VideoGroupItem();

  int? id;
  String? name;

  factory VideoGroupItem.fromJson(Map<String, dynamic> json) =>
      _$VideoGroupItemFromJson(json);

  toJson() => _$VideoGroupItemToJson(this);
}
