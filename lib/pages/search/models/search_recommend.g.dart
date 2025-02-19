// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_recommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRecommendResult _$SearchRecommendResultFromJson(
        Map<String, dynamic> json) =>
    SearchRecommendResult(
      (json['hots'] as List<dynamic>?)
          ?.map(
              (e) => SearchRecommendHotItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchRecommendResultToJson(
        SearchRecommendResult instance) =>
    <String, dynamic>{
      'hots': instance.hots,
    };

SearchRecommendHotItem _$SearchRecommendHotItemFromJson(
        Map<String, dynamic> json) =>
    SearchRecommendHotItem(
      json['first'] as String?,
      (json['second'] as num?)?.toInt(),
      (json['iconType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchRecommendHotItemToJson(
        SearchRecommendHotItem instance) =>
    <String, dynamic>{
      'first': instance.first,
      'second': instance.second,
      'iconType': instance.iconType,
    };
