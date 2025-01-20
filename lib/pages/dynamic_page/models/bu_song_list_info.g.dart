// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bu_song_list_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuSongPlayListWarp _$BuSongPlayListWarpFromJson(Map<String, dynamic> json) =>
    BuSongPlayListWarp(
      (json['result'] as List<dynamic>?)
          ?.map((e) => BuSongListInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hasTaste'] as bool?,
      (json['category'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BuSongPlayListWarpToJson(BuSongPlayListWarp instance) =>
    <String, dynamic>{
      'result': instance.result,
      'hasTaste': instance.hasTaste,
      'category': instance.category,
    };

BuSongListInfo _$BuSongListInfoFromJson(Map<String, dynamic> json) =>
    BuSongListInfo(
      id: (json['id'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      name: json['name'] as String?,
      copywriter: json['copywriter'] as String?,
      picUrl: json['picUrl'] as String?,
      canDislike: json['canDislike'] as bool?,
      trackNumberUpdateTime: (json['trackNumberUpdateTime'] as num?)?.toInt(),
      playCount: (json['playCount'] as num?)?.toInt(),
      trackCount: (json['trackCount'] as num?)?.toInt(),
      highQuality: json['highQuality'] as bool?,
      alg: json['alg'] as String?,
    );

Map<String, dynamic> _$BuSongListInfoToJson(BuSongListInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'copywriter': instance.copywriter,
      'picUrl': instance.picUrl,
      'canDislike': instance.canDislike,
      'trackNumberUpdateTime': instance.trackNumberUpdateTime,
      'playCount': instance.playCount,
      'trackCount': instance.trackCount,
      'highQuality': instance.highQuality,
      'alg': instance.alg,
    };
