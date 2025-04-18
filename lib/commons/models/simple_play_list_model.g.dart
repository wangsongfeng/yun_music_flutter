// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_play_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimplePlayListModel _$SimplePlayListModelFromJson(Map<String, dynamic> json) =>
    SimplePlayListModel(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['picUrl'] as String?,
      json['coverImgUrl'] as String?,
      (json['playCount'] as num).toInt(),
      (json['trackCount'] as num).toInt(),
      (json['updateTime'] as num?)?.toInt(),
      (json['officialTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['creator'] == null
          ? null
          : Creator.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SimplePlayListModelToJson(
        SimplePlayListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'coverImgUrl': instance.coverImgUrl,
      'playCount': instance.playCount,
      'trackCount': instance.trackCount,
      'updateTime': instance.updateTime,
      'officialTags': instance.officialTags,
      'creator': instance.creator,
    };
