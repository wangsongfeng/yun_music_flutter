import 'package:json_annotation/json_annotation.dart';

part 'search_video_model.g.dart';

@JsonSerializable()
class SearchVideos extends Object {
  @JsonKey(name: 'videoCount')
  int videoCount;

  @JsonKey(name: 'hasMore')
  bool hasMore;

  @JsonKey(name: 'videos')
  List<Videos> videos;

  SearchVideos(
    this.videoCount,
    this.hasMore,
    this.videos,
  );

  factory SearchVideos.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchVideosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchVideosToJson(this);
}

@JsonSerializable()
class Videos extends Object {
  @JsonKey(name: 'coverUrl')
  String coverUrl;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'durationms')
  int durationms;

  @JsonKey(name: 'playTime')
  int playTime;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'creator')
  List<Creator> creator;

  @JsonKey(name: 'vid')
  String vid;

  @JsonKey(name: 'alg')
  String alg;

  Videos(
    this.coverUrl,
    this.title,
    this.durationms,
    this.playTime,
    this.type,
    this.creator,
    this.vid,
    this.alg,
  );

  factory Videos.fromJson(Map<String, dynamic> srcJson) =>
      _$VideosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideosToJson(this);
}

@JsonSerializable()
class Creator extends Object {
  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'userName')
  String? userName;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'avatarUrl')
  String? avatarUrl;

  @JsonKey(name: 'signature')
  String? signature;

  @JsonKey(name: 'vipType')
  int? vipType;

  @JsonKey(name: 'userType')
  int? userType;

  @JsonKey(name: 'avatarDetail')
  CreatorAvatarDetail? avatarDetail;

  @JsonKey(name: 'vipRights')
  CreatorVipRights? vipRights;

  Creator(
    this.userId,
    this.userName,
    this.nickname,
    this.avatarUrl,
    this.signature,
    this.vipType,
    this.userType,
    this.avatarDetail,
    this.vipRights,
  );

  factory Creator.fromJson(Map<String, dynamic> srcJson) =>
      _$CreatorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CreatorToJson(this);

  String get name => userName ?? nickname ?? '佚名';
}

@JsonSerializable()
class CreatorAvatarDetail {
  CreatorAvatarDetail();
  @JsonKey(name: 'userType')
  int? userType;
  @JsonKey(name: 'identityLevel')
  int? identityLevel;
  @JsonKey(name: 'identityIconUrl')
  String? identityIconUrl;

  factory CreatorAvatarDetail.fromJson(Map<String, dynamic> json) =>
      _$CreatorAvatarDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorAvatarDetailToJson(this);
}

@JsonSerializable()
class CreatorVipRights {
  CreatorVipRights();
  @JsonKey(name: 'associator')
  VipAssociator? associator;
  @JsonKey(name: 'musicPackage')
  VipAssociator? musicPackage;
  @JsonKey(name: 'redVipAnnualCount')
  int? redVipAnnualCount;
  @JsonKey(name: 'redVipLevel')
  int? redVipLevel;

  factory CreatorVipRights.fromJson(Map<String, dynamic> json) =>
      _$CreatorVipRightsFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorVipRightsToJson(this);
}

@JsonSerializable()
class VipAssociator {
  VipAssociator();
  @JsonKey(name: 'vipCode')
  int? vipCode;
  @JsonKey(name: 'rights')
  bool? rights;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;

  factory VipAssociator.fromJson(Map<String, dynamic> json) =>
      _$VipAssociatorFromJson(json);

  Map<String, dynamic> toJson() => _$VipAssociatorToJson(this);
}
