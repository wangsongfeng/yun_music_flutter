// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoCategory _$VideoCategoryFromJson(Map<String, dynamic> json) =>
    VideoCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      relatedVideoType: json['relatedVideoType'] as String?,
      selectTab: json['selectTab'] as bool?,
    );

Map<String, dynamic> _$VideoCategoryToJson(VideoCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'relatedVideoType': instance.relatedVideoType,
      'selectTab': instance.selectTab,
    };
