// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_recom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogRecomModel _$BlogRecomModelFromJson(Map<String, dynamic> json) =>
    BlogRecomModel(
      categoryId: (json['categoryId'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      radios: (json['radios'] as List<dynamic>?)
          ?.map((e) => BlogRadios.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlogRecomModelToJson(BlogRecomModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'radios': instance.radios,
    };

BlogRadios _$BlogRadiosFromJson(Map<String, dynamic> json) => BlogRadios(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      rcmdText: json['rcmdText'] as String?,
      radioFeeType: (json['radioFeeType'] as num?)?.toInt(),
      feeScope: (json['feeScope'] as num?)?.toInt(),
      picUrl: json['picUrl'] as String?,
      programCount: (json['programCount'] as num?)?.toInt(),
      subCount: (json['subCount'] as num?)?.toInt(),
      subed: json['subed'] as bool?,
      playCount: (json['playCount'] as num?)?.toInt(),
      alg: json['alg'] as String?,
      lastProgramName: json['lastProgramName'] as String?,
      traceId: json['traceId'] as String?,
      icon: json['icon'] == null
          ? null
          : BlogIcons.fromJson(json['icon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogRadiosToJson(BlogRadios instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rcmdText': instance.rcmdText,
      'radioFeeType': instance.radioFeeType,
      'feeScope': instance.feeScope,
      'picUrl': instance.picUrl,
      'programCount': instance.programCount,
      'subCount': instance.subCount,
      'subed': instance.subed,
      'playCount': instance.playCount,
      'alg': instance.alg,
      'lastProgramName': instance.lastProgramName,
      'traceId': instance.traceId,
      'icon': instance.icon,
    };

BlogIcons _$BlogIconsFromJson(Map<String, dynamic> json) => BlogIcons(
      type: json['type'] as String?,
      value: json['value'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$BlogIconsToJson(BlogIcons instance) => <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'color': instance.color,
    };
