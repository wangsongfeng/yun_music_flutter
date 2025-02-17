// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hishort_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HishortInfo _$HishortInfoFromJson(Map<String, dynamic> json) => HishortInfo(
      (json['collectNums'] as num?)?.toInt(),
      (json['likeNums'] as num?)?.toInt(),
      json['vidName'] as String?,
      (json['payNVideo'] as num?)?.toInt(),
      (json['isCollect'] as num?)?.toInt(),
      (json['consumeCoin'] as num?)?.toInt(),
      (json['firstPlayId'] as num?)?.toInt(),
      json['coverUrl'] as String?,
      (json['totalNum'] as num?)?.toInt(),
      (json['isLike'] as num?)?.toInt(),
      json['firstPlayUrl'] as String?,
      (json['cpId'] as num?)?.toInt(),
      (json['vidId'] as num?)?.toInt(),
      json['vidDescribe'] as String?,
    );

Map<String, dynamic> _$HishortInfoToJson(HishortInfo instance) =>
    <String, dynamic>{
      'collectNums': instance.collectNums,
      'likeNums': instance.likeNums,
      'vidName': instance.vidName,
      'payNVideo': instance.payNVideo,
      'isCollect': instance.isCollect,
      'consumeCoin': instance.consumeCoin,
      'firstPlayId': instance.firstPlayId,
      'coverUrl': instance.coverUrl,
      'totalNum': instance.totalNum,
      'isLike': instance.isLike,
      'firstPlayUrl': instance.firstPlayUrl,
      'cpId': instance.cpId,
      'vidId': instance.vidId,
      'vidDescribe': instance.vidDescribe,
    };
