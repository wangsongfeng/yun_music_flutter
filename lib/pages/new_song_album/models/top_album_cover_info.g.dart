// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_album_cover_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopAlbumCoverInfo _$TopAlbumCoverInfoFromJson(Map<String, dynamic> json) =>
    TopAlbumCoverInfo(
      (json['alias'] as List<dynamic>).map((e) => e as String).toList(),
      (json['artists'] as List<dynamic>)
          .map((e) => Ar.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['description'] as String,
      (json['publishTime'] as num).toInt(),
      json['picUrl'] as String,
      json['name'] as String,
      (json['id'] as num).toInt(),
      (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$TopAlbumCoverInfoToJson(TopAlbumCoverInfo instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'artists': instance.artists,
      'description': instance.description,
      'publishTime': instance.publishTime,
      'picUrl': instance.picUrl,
      'name': instance.name,
      'id': instance.id,
      'size': instance.size,
    };
