// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchVideos _$SearchVideosFromJson(Map<String, dynamic> json) => SearchVideos(
      (json['videoCount'] as num).toInt(),
      json['hasMore'] as bool,
      (json['videos'] as List<dynamic>)
          .map((e) => Videos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchVideosToJson(SearchVideos instance) =>
    <String, dynamic>{
      'videoCount': instance.videoCount,
      'hasMore': instance.hasMore,
      'videos': instance.videos,
    };

Videos _$VideosFromJson(Map<String, dynamic> json) => Videos(
      json['coverUrl'] as String,
      json['title'] as String,
      (json['durationms'] as num).toInt(),
      (json['playTime'] as num).toInt(),
      (json['type'] as num).toInt(),
      (json['creator'] as List<dynamic>)
          .map((e) => Creator.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['vid'] as String,
      json['alg'] as String,
    );

Map<String, dynamic> _$VideosToJson(Videos instance) => <String, dynamic>{
      'coverUrl': instance.coverUrl,
      'title': instance.title,
      'durationms': instance.durationms,
      'playTime': instance.playTime,
      'type': instance.type,
      'creator': instance.creator,
      'vid': instance.vid,
      'alg': instance.alg,
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator(
      (json['userId'] as num).toInt(),
      json['userName'] as String?,
      json['nickname'] as String?,
      json['avatarUrl'] as String?,
      json['signature'] as String?,
      (json['vipType'] as num?)?.toInt(),
      (json['userType'] as num?)?.toInt(),
      json['avatarDetail'] == null
          ? null
          : CreatorAvatarDetail.fromJson(
              json['avatarDetail'] as Map<String, dynamic>),
      json['vipRights'] == null
          ? null
          : CreatorVipRights.fromJson(
              json['vipRights'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'signature': instance.signature,
      'vipType': instance.vipType,
      'userType': instance.userType,
      'avatarDetail': instance.avatarDetail,
      'vipRights': instance.vipRights,
    };

CreatorAvatarDetail _$CreatorAvatarDetailFromJson(Map<String, dynamic> json) =>
    CreatorAvatarDetail()
      ..userType = (json['userType'] as num?)?.toInt()
      ..identityLevel = (json['identityLevel'] as num?)?.toInt()
      ..identityIconUrl = json['identityIconUrl'] as String?;

Map<String, dynamic> _$CreatorAvatarDetailToJson(
        CreatorAvatarDetail instance) =>
    <String, dynamic>{
      'userType': instance.userType,
      'identityLevel': instance.identityLevel,
      'identityIconUrl': instance.identityIconUrl,
    };

CreatorVipRights _$CreatorVipRightsFromJson(Map<String, dynamic> json) =>
    CreatorVipRights()
      ..associator = json['associator'] == null
          ? null
          : VipAssociator.fromJson(json['associator'] as Map<String, dynamic>)
      ..musicPackage = json['musicPackage'] == null
          ? null
          : VipAssociator.fromJson(json['musicPackage'] as Map<String, dynamic>)
      ..redVipAnnualCount = (json['redVipAnnualCount'] as num?)?.toInt()
      ..redVipLevel = (json['redVipLevel'] as num?)?.toInt();

Map<String, dynamic> _$CreatorVipRightsToJson(CreatorVipRights instance) =>
    <String, dynamic>{
      'associator': instance.associator,
      'musicPackage': instance.musicPackage,
      'redVipAnnualCount': instance.redVipAnnualCount,
      'redVipLevel': instance.redVipLevel,
    };

VipAssociator _$VipAssociatorFromJson(Map<String, dynamic> json) =>
    VipAssociator()
      ..vipCode = (json['vipCode'] as num?)?.toInt()
      ..rights = json['rights'] as bool?
      ..iconUrl = json['iconUrl'] as String?;

Map<String, dynamic> _$VipAssociatorToJson(VipAssociator instance) =>
    <String, dynamic>{
      'vipCode': instance.vipCode,
      'rights': instance.rights,
      'iconUrl': instance.iconUrl,
    };
