// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecomModelWrap _$RecomModelWrapFromJson(Map<String, dynamic> json) =>
    RecomModelWrap(
      (json['code'] as num?)?.toInt(),
      json['data'] == null
          ? null
          : RecomModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecomModelWrapToJson(RecomModelWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
    };

RecomModel _$RecomModelFromJson(Map<String, dynamic> json) => RecomModel(
      json['cursor'] as String?,
      (json['blocks'] as List<dynamic>)
          .map((e) => Blocks.fromJson(e as Map<String, dynamic>))
          .toList(),
      PageConfig.fromJson(json['pageConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecomModelToJson(RecomModel instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'blocks': instance.blocks,
      'pageConfig': instance.pageConfig,
    };

Blocks _$BlocksFromJson(Map<String, dynamic> json) => Blocks(
      json['blockCode'] as String,
      json['showType'] as String,
      json['extInfo'],
      json['uiElement'] == null
          ? null
          : UiElementModel.fromJson(json['uiElement'] as Map<String, dynamic>),
      (json['creatives'] as List<dynamic>?)
          ?.map((e) => CreativeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['canClose'] as bool,
    );

Map<String, dynamic> _$BlocksToJson(Blocks instance) => <String, dynamic>{
      'blockCode': instance.blockCode,
      'showType': instance.showType,
      'extInfo': instance.extInfo,
      'uiElement': instance.uiElement,
      'creatives': instance.creatives,
      'canClose': instance.canClose,
    };

PageConfig _$PageConfigFromJson(Map<String, dynamic> json) => PageConfig(
      json['refreshToast'] as String?,
      json['nodataToast'] as String?,
      (json['refreshInterval'] as num).toInt(),
    );

Map<String, dynamic> _$PageConfigToJson(PageConfig instance) =>
    <String, dynamic>{
      'refreshToast': instance.refreshToast,
      'nodataToast': instance.nodataToast,
      'refreshInterval': instance.refreshInterval,
    };
