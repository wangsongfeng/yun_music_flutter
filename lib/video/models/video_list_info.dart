import 'package:json_annotation/json_annotation.dart';

import 'avatar_info.dart';

part 'video_list_info.g.dart';

@JsonSerializable()
class VideoInfo extends Object {
  @JsonKey(name: "aweme_id")
  String? aweme_id;

  @JsonKey(name: "desc")
  String? desc;

  @JsonKey(name: "create_time")
  int? create_time;

  @JsonKey(name: "music")
  Music? music;

  @JsonKey(name: "video")
  Video? video;

  @JsonKey(name: "share_url")
  String? share_url;

  @JsonKey(name: "statistics")
  Statistics? statistics;

  @JsonKey(name: "status")
  Status? status;

  @JsonKey(name: "text_extra")
  List<TextExtra>? text_extra;

  @JsonKey(name: "is_top")
  int? is_top;

  @JsonKey(name: "share_info")
  ShareInfo? share_info;

  @JsonKey(name: "duration")
  int? duration;

  @JsonKey(name: "risk_infos")
  RiskInfos? risk_infos;

  @JsonKey(name: "author_user_id")
  int? author_user_id;

  @JsonKey(name: "prevent_download")
  bool? prevent_download;

  @JsonKey(name: "avatar")
  AvatarInfo? avatar;

  VideoInfo(
      {this.aweme_id,
      this.desc,
      this.create_time,
      this.music,
      this.video,
      this.share_url,
      this.statistics,
      this.status,
      this.text_extra,
      this.is_top,
      this.share_info,
      this.duration,
      this.risk_infos,
      this.author_user_id,
      this.prevent_download,
      this.avatar});

  factory VideoInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}

@JsonSerializable()
class Music extends Object {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "author")
  String? author;

  @JsonKey(name: "cover_medium")
  CoverMedium? cover_medium;

  @JsonKey(name: "cover_thumb")
  CoverMedium? cover_thumb;

  @JsonKey(name: "play_url")
  PlayUrl? play_url;

  @JsonKey(name: "duration")
  int? duration;

  @JsonKey(name: "user_count")
  int? user_count;

  @JsonKey(name: "owner_nickname")
  String? owner_nickname;

  @JsonKey(name: "is_original")
  bool? is_original;

  Music(
      {this.id,
      this.title,
      this.author,
      this.cover_medium,
      this.cover_thumb,
      this.play_url,
      this.duration,
      this.user_count,
      this.owner_nickname,
      this.is_original});
  factory Music.fromJson(Map<String, dynamic> srcJson) =>
      _$MusicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MusicToJson(this);
}

@JsonSerializable()
class CoverMedium extends Object {
  @JsonKey(name: "uri")
  String? uri;

  @JsonKey(name: "url_list")
  List<String>? url_list;

  @JsonKey(name: "width")
  int? width;

  @JsonKey(name: "height")
  int? height;

  CoverMedium({this.uri, this.url_list, this.width, this.height});

  factory CoverMedium.fromJson(Map<String, dynamic> srcJson) =>
      _$CoverMediumFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CoverMediumToJson(this);
}

@JsonSerializable()
class PlayUrl extends Object {
  @JsonKey(name: "uri")
  String? uri;

  @JsonKey(name: "url_list")
  List<String>? url_list;

  @JsonKey(name: "width")
  int? width;

  @JsonKey(name: "height")
  int? height;

  @JsonKey(name: "url_key")
  String? url_key;

  PlayUrl({this.uri, this.url_list, this.width, this.height, this.url_key});

  factory PlayUrl.fromJson(Map<String, dynamic> srcJson) =>
      _$PlayUrlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlayUrlToJson(this);
}

@JsonSerializable()
class Video extends Object {
  @JsonKey(name: "play_addr")
  PlayAddr? play_addr;

  @JsonKey(name: "cover")
  CoverMedium? cover;

  @JsonKey(name: "poster")
  String? poster;

  @JsonKey(name: "height")
  int? height;

  @JsonKey(name: "width")
  int? width;

  @JsonKey(name: "ratio")
  String? ratio;

  @JsonKey(name: "use_static_cover")
  bool? use_static_cover;

  @JsonKey(name: "duration")
  int? duration;

  Video(
      {this.play_addr,
      this.cover,
      this.poster,
      this.height,
      this.width,
      this.ratio,
      this.use_static_cover,
      this.duration});

  factory Video.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

@JsonSerializable()
class PlayAddr extends Object {
  @JsonKey(name: "uri")
  String? uri;

  @JsonKey(name: "url_list")
  List<String>? url_list;

  @JsonKey(name: "width")
  int? width;

  @JsonKey(name: "height")
  int? height;

  @JsonKey(name: "url_key")
  String? url_key;

  @JsonKey(name: "data_size")
  int? data_size;

  @JsonKey(name: "file_hash")
  String? file_hash;

  @JsonKey(name: "file_cs")
  String? file_cs;

  PlayAddr(
      {this.uri,
      this.url_list,
      this.width,
      this.height,
      this.url_key,
      this.data_size,
      this.file_hash,
      this.file_cs});

  factory PlayAddr.fromJson(Map<String, dynamic> srcJson) =>
      _$PlayAddrFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlayAddrToJson(this);
}

@JsonSerializable()
class Statistics extends Object {
  @JsonKey(name: "admire_count")
  int? admire_count;

  @JsonKey(name: "comment_count")
  int? comment_count;

  @JsonKey(name: "digg_count")
  int? digg_count;

  @JsonKey(name: "collect_count")
  int? collect_count;

  @JsonKey(name: "play_count")
  int? play_count;

  @JsonKey(name: "share_count")
  int? share_count;

  Statistics(
      {this.admire_count,
      this.comment_count,
      this.digg_count,
      this.collect_count,
      this.play_count,
      this.share_count});

  factory Statistics.fromJson(Map<String, dynamic> srcJson) =>
      _$StatisticsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);
}

@JsonSerializable()
class Status extends Object {
  @JsonKey(name: "listen_video_status")
  int? listen_video_status;

  @JsonKey(name: "is_delete")
  bool? is_delete;

  @JsonKey(name: "allow_share")
  bool? allow_share;

  @JsonKey(name: "is_prohibited")
  bool? is_prohibited;

  @JsonKey(name: "in_reviewing")
  bool? in_reviewing;

  @JsonKey(name: "part_see")
  int? part_see;

  @JsonKey(name: "private_status")
  int? private_status;

  Status(
      {this.listen_video_status,
      this.is_delete,
      this.allow_share,
      this.is_prohibited,
      this.in_reviewing,
      this.part_see,
      this.private_status});

  factory Status.fromJson(Map<String, dynamic> srcJson) =>
      _$StatusFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

@JsonSerializable()
class ShareInfo extends Object {
  @JsonKey(name: "share_url")
  String? share_url;

  @JsonKey(name: "share_link_desc")
  String? share_link_desc;

  ShareInfo({this.share_url, this.share_link_desc});

  factory ShareInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$ShareInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShareInfoToJson(this);
}

@JsonSerializable()
class RiskInfos extends Object {
  @JsonKey(name: "vote")
  bool? vote;

  @JsonKey(name: "warn")
  bool? warn;

  @JsonKey(name: "risk_sink")
  bool? risk_sink;

  @JsonKey(name: "type")
  int? type;

  @JsonKey(name: "content")
  String? content;

  RiskInfos({this.vote, this.warn, this.risk_sink, this.type, this.content});

  factory RiskInfos.fromJson(Map<String, dynamic> srcJson) =>
      _$RiskInfosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RiskInfosToJson(this);
}

@JsonSerializable()
class TextExtra extends Object {
  @JsonKey(name: "start")
  int? start;

  @JsonKey(name: "end")
  int? end;

  @JsonKey(name: "type")
  int? type;

  @JsonKey(name: "hashtag_name")
  String? hashtag_name;

  @JsonKey(name: "hashtag_id")
  String? hashtag_id;

  @JsonKey(name: "is_commerce")
  bool? is_commerce;

  @JsonKey(name: "caption_start")
  int? caption_start;

  @JsonKey(name: "caption_end")
  int? caption_end;

  TextExtra(
      {this.start,
      this.end,
      this.type,
      this.hashtag_name,
      this.hashtag_id,
      this.is_commerce,
      this.caption_start,
      this.caption_end});

  factory TextExtra.fromJson(Map<String, dynamic> srcJson) =>
      _$TextExtraFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TextExtraToJson(this);
}
