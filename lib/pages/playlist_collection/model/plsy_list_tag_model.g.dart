// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plsy_list_tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayListTagModel _$PlayListTagModelFromJson(Map<String, dynamic> json) =>
    PlayListTagModel(
      json['activity'] as bool,
      json['hot'] as bool,
      json['name'] as String,
      (json['category'] as num).toInt(),
      (json['type'] as num).toInt(),
      (json['usedCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayListTagModelToJson(PlayListTagModel instance) =>
    <String, dynamic>{
      'activity': instance.activity,
      'hot': instance.hot,
      'name': instance.name,
      'category': instance.category,
      'type': instance.type,
      'usedCount': instance.usedCount,
    };
