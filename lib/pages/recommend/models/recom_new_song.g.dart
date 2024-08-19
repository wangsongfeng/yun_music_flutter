// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recom_new_song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecomNewSong _$RecomNewSongFromJson(Map<String, dynamic> json) => RecomNewSong(
      SongData.fromJson(json['songData'] as Map<String, dynamic>),
      PrivilegeModel.fromJson(json['songPrivilege'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecomNewSongToJson(RecomNewSong instance) =>
    <String, dynamic>{
      'songData': instance.songData,
      'songPrivilege': instance.songPrivilege,
    };

SongData _$SongDataFromJson(Map<String, dynamic> json) => SongData(
      json['name'] as String,
      (json['id'] as num).toInt(),
      (json['fee'] as num).toInt(),
      (json['copyright'] as num?)?.toInt(),
      (json['originCoverType'] as num?)?.toInt(),
      (json['mvid'] as num).toInt(),
      (json['alias'] as List<dynamic>).map((e) => e as String).toList(),
      (json['artists'] as List<dynamic>)
          .map((e) => Ar.fromJson(e as Map<String, dynamic>))
          .toList(),
      AlbumSimple.fromJson(json['album'] as Map<String, dynamic>),
      json['privilege'] == null
          ? null
          : PrivilegeModel.fromJson(json['privilege'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SongDataToJson(SongData instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'fee': instance.fee,
      'copyright': instance.copyright,
      'originCoverType': instance.originCoverType,
      'mvid': instance.mvid,
      'alias': instance.alias,
      'artists': instance.artists,
      'album': instance.album,
      'privilege': instance.songPrivilege,
    };
