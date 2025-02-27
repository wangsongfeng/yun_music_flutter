// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_hot_wrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHotWrap _$SearchHotWrapFromJson(Map<String, dynamic> json) =>
    SearchHotWrap(
      (json['data'] as List<dynamic>?)
          ?.map((e) => SearchHotDataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchHotWrapToJson(SearchHotWrap instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
    };

SearchHotDataItem _$SearchHotDataItemFromJson(Map<String, dynamic> json) =>
    SearchHotDataItem(
      json['searchWord'] as String?,
      json['content'] as String?,
      (json['score'] as num?)?.toInt(),
      json['iconUrl'] as String?,
      (json['source'] as num?)?.toInt(),
      (json['iconType'] as num?)?.toInt(),
      json['url'] as String?,
      json['alg'] as String?,
    );

Map<String, dynamic> _$SearchHotDataItemToJson(SearchHotDataItem instance) =>
    <String, dynamic>{
      'searchWord': instance.searchWord,
      'content': instance.content,
      'score': instance.score,
      'iconUrl': instance.iconUrl,
      'source': instance.source,
      'iconType': instance.iconType,
      'url': instance.url,
      'alg': instance.alg,
    };

SearchHotTopicWrap _$SearchHotTopicWrapFromJson(Map<String, dynamic> json) =>
    SearchHotTopicWrap(
      (json['code'] as num?)?.toInt(),
      (json['hot'] as List<dynamic>?)
          ?.map((e) => SearchHotTopicItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchHotTopicWrapToJson(SearchHotTopicWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'hot': instance.hot,
    };

SearchHotTopicItem _$SearchHotTopicItemFromJson(Map<String, dynamic> json) =>
    SearchHotTopicItem(
      json['title'] as String?,
      (json['text'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['actId'] as num?)?.toInt(),
      (json['participateCount'] as num?)?.toInt(),
      json['sharePicUrl'] as String?,
    );

Map<String, dynamic> _$SearchHotTopicItemToJson(SearchHotTopicItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'actId': instance.actId,
      'participateCount': instance.participateCount,
      'sharePicUrl': instance.sharePicUrl,
    };

SearchComplexSimQueryItem _$SearchComplexSimQueryItemFromJson(
        Map<String, dynamic> json) =>
    SearchComplexSimQueryItem()
      ..keyword = json['keyword'] as String?
      ..alg = json['alg'] as String?;

Map<String, dynamic> _$SearchComplexSimQueryItemToJson(
        SearchComplexSimQueryItem instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'alg': instance.alg,
    };
