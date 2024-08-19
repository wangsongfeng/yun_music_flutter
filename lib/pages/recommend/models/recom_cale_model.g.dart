// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recom_cale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecomCaleModel _$RecomCaleModelFromJson(Map<String, dynamic> json) =>
    RecomCaleModel(
      (json['startTime'] as num).toInt(),
      (json['endTime'] as num).toInt(),
      json['subed'] as bool,
      (json['subCount'] as num?)?.toInt(),
      json['canSubscribe'] as bool,
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RecomCaleModelToJson(RecomCaleModel instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'subed': instance.subed,
      'subCount': instance.subCount,
      'canSubscribe': instance.canSubscribe,
      'tags': instance.tags,
    };
