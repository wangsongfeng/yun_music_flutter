// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyric_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lyrics2 _$Lyrics2FromJson(Map<String, dynamic> json) => Lyrics2(
      json['lyric'] as String?,
      (json['version'] as num?)?.toInt(),
    );

Map<String, dynamic> _$Lyrics2ToJson(Lyrics2 instance) => <String, dynamic>{
      'lyric': instance.lyric,
      'version': instance.version,
    };

SongLyricWrap _$SongLyricWrapFromJson(Map<String, dynamic> json) =>
    SongLyricWrap(
      json['sgc'] as bool?,
      json['sfy'] as bool?,
      json['qfy'] as bool?,
      Lyrics2.fromJson(json['lrc'] as Map<String, dynamic>),
      Lyrics2.fromJson(json['klyric'] as Map<String, dynamic>),
      Lyrics2.fromJson(json['tlyric'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SongLyricWrapToJson(SongLyricWrap instance) =>
    <String, dynamic>{
      'sgc': instance.sgc,
      'sfy': instance.sfy,
      'qfy': instance.qfy,
      'lrc': instance.lrc,
      'klyric': instance.klyric,
      'tlyric': instance.tlyric,
    };
