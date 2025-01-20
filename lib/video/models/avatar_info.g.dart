// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarInfo _$AvatarInfoFromJson(Map<String, dynamic> json) => AvatarInfo(
      json['avatar_168x168'] == null
          ? null
          : AvatarUrlsInfo.fromJson(
              json['avatar_168x168'] as Map<String, dynamic>),
      json['avatar_300x300'] == null
          ? null
          : AvatarUrlsInfo.fromJson(
              json['avatar_300x300'] as Map<String, dynamic>),
      json['city'] as String?,
      json['uid'] as String?,
      json['nickname'] as String?,
    );

Map<String, dynamic> _$AvatarInfoToJson(AvatarInfo instance) =>
    <String, dynamic>{
      'avatar_168x168': instance.avatar_168x168,
      'avatar_300x300': instance.avatar_300x300,
      'city': instance.city,
      'uid': instance.uid,
      'nickname': instance.nickname,
    };

AvatarUrlsInfo _$AvatarUrlsInfoFromJson(Map<String, dynamic> json) =>
    AvatarUrlsInfo(
      (json['width'] as num?)?.toInt(),
      (json['height'] as num?)?.toInt(),
      (json['url_list'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['uri'] as String?,
    );

Map<String, dynamic> _$AvatarUrlsInfoToJson(AvatarUrlsInfo instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'url_list': instance.url_list,
      'uri': instance.uri,
    };
