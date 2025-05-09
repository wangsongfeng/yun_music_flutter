// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      json['name'] as String,
      (json['id'] as num).toInt(),
      (json['ar'] as List<dynamic>)
          .map((e) => Ar.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['alia'] as List<dynamic>).map((e) => e as String).toList(),
      (json['fee'] as num).toInt(),
      (json['v'] as num).toInt(),
      AlbumSimple.fromJson(json['al'] as Map<String, dynamic>),
      (json['copyright'] as num?)?.toInt(),
      (json['originCoverType'] as num?)?.toInt(),
      (json['mv'] as num?)?.toInt(),
      json['privilege'] == null
          ? null
          : PrivilegeModel.fromJson(json['privilege'] as Map<String, dynamic>),
      json['actionType'] as String?,
      json['originSongSimpleData'] == null
          ? null
          : OriginSongSimpleData.fromJson(
              json['originSongSimpleData'] as Map<String, dynamic>),
      (json['st'] as num).toInt(),
      (json['dt'] as num?)?.toInt(),
      json['tns'] as List<dynamic>?,
    )..reason = json['reason'] as String?;

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'ar': instance.ar,
      'alia': instance.alia,
      'fee': instance.fee,
      'v': instance.v,
      'st': instance.st,
      'dt': instance.dt,
      'al': instance.al,
      'copyright': instance.copyright,
      'originCoverType': instance.originCoverType,
      'mv': instance.mv,
      'privilege': instance.privilege,
      'actionType': instance.actionType,
      'originSongSimpleData': instance.originSongSimpleData,
      'tns': instance.tns,
      'reason': instance.reason,
    };

Ar _$ArFromJson(Map<String, dynamic> json) => Ar(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['tns'] as List<dynamic>?,
      json['alias'] as List<dynamic>?,
      json['picUrl'] as String?,
      json['followed'] as bool?,
      (json['accountId'] as num?)?.toInt(),
      (json['fansCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ArToJson(Ar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tns': instance.tns,
      'alias': instance.alias,
      'picUrl': instance.picUrl,
      'followed': instance.followed,
      'accountId': instance.accountId,
      'fansCount': instance.fansCount,
    };

AlbumSimple _$AlbumSimpleFromJson(Map<String, dynamic> json) => AlbumSimple(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['picUrl'] as String?,
      json['pic_str'] as String?,
      (json['publishTime'] as num?)?.toInt(),
      json['tags'] as String?,
      (json['copyrightId'] as num?)?.toInt(),
      (json['companyId'] as num?)?.toInt(),
      json['company'] as String?,
      json['description'] as String?,
      json['briefDesc'] as String?,
      json['artist'] == null
          ? null
          : Artists.fromJson(json['artist'] as Map<String, dynamic>),
      (json['artists'] as List<dynamic>?)
          ?.map((e) => Artists.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumSimpleToJson(AlbumSimple instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'pic_str': instance.picStr,
      'publishTime': instance.publishTime,
      'tags': instance.tags,
      'copyrightId': instance.copyrightId,
      'companyId': instance.companyId,
      'company': instance.company,
      'description': instance.description,
      'briefDesc': instance.briefDesc,
      'artist': instance.artist,
      'artists': instance.artists,
    };

OriginSongSimpleData _$OriginSongSimpleDataFromJson(
        Map<String, dynamic> json) =>
    OriginSongSimpleData(
      (json['artists'] as List<dynamic>)
          .map((e) => Ar.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OriginSongSimpleDataToJson(
        OriginSongSimpleData instance) =>
    <String, dynamic>{
      'artists': instance.artists,
    };
