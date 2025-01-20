// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongInfoDto _$SongInfoDtoFromJson(Map<String, dynamic> json) => SongInfoDto(
      (json['id'] as num?)?.toInt(),
      json['url'] as String?,
      json['md5'] as String?,
      (json['time'] as num?)?.toInt(),
      json['mp3'] as String?,
      json['level'] as String?,
    );

Map<String, dynamic> _$SongInfoDtoToJson(SongInfoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'md5': instance.md5,
      'time': instance.time,
      'mp3': instance.mp3,
      'level': instance.level,
    };

SongInfoListDto _$SongInfoListDtoFromJson(Map<String, dynamic> json) =>
    SongInfoListDto(
      (json['data'] as List<dynamic>?)
          ?.map((e) => SongInfoDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongInfoListDtoToJson(SongInfoListDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
