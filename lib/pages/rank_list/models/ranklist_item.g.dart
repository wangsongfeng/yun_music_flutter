// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranklist_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RanklistItem _$RanklistItemFromJson(Map<String, dynamic> json) => RanklistItem(
      (json['tracks'] as List<dynamic>)
          .map((e) => RankListTracks.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['updateFrequency'] as String,
      (json['userId'] as num).toInt(),
      (json['subscribedCount'] as num).toInt(),
      json['coverImgUrl'] as String,
      (json['playCount'] as num).toInt(),
      json['name'] as String,
      (json['id'] as num).toInt(),
      (json['updateTime'] as num).toInt(),
    );

Map<String, dynamic> _$RanklistItemToJson(RanklistItem instance) =>
    <String, dynamic>{
      'tracks': instance.tracks,
      'updateFrequency': instance.updateFrequency,
      'userId': instance.userId,
      'subscribedCount': instance.subscribedCount,
      'coverImgUrl': instance.coverImgUrl,
      'playCount': instance.playCount,
      'name': instance.name,
      'id': instance.id,
      'updateTime': instance.updateTime,
    };

RankListTracks _$RankListTracksFromJson(Map<String, dynamic> json) =>
    RankListTracks(
      json['first'] as String,
      json['second'] as String,
    );

Map<String, dynamic> _$RankListTracksToJson(RankListTracks instance) =>
    <String, dynamic>{
      'first': instance.first,
      'second': instance.second,
    };
