// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mine_music_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MineMusicList _$MineMusicListFromJson(Map<String, dynamic> json) =>
    MineMusicList(
      json['coverUrl'] as String?,
      json['name'] as String?,
      (json['num'] as num?)?.toInt(),
      json['desc'] as String?,
    );

Map<String, dynamic> _$MineMusicListToJson(MineMusicList instance) =>
    <String, dynamic>{
      'coverUrl': instance.coverUrl,
      'name': instance.name,
      'num': instance.num,
      'desc': instance.desc,
    };
