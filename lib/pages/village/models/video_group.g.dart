// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoGroupSourceList _$VideoGroupSourceListFromJson(
        Map<String, dynamic> json) =>
    VideoGroupSourceList()
      ..msg = json['msg'] as String?
      ..code = (json['code'] as num?)?.toInt()
      ..hasmore = json['hasmore'] as bool?
      ..rcmdLimit = (json['rcmdLimit'] as num?)?.toInt()
      ..datas = (json['datas'] as List<dynamic>?)
          ?.map((e) => VideoSurceItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$VideoGroupSourceListToJson(
        VideoGroupSourceList instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'hasmore': instance.hasmore,
      'rcmdLimit': instance.rcmdLimit,
      'datas': instance.datas,
    };

VideoSurceItem _$VideoSurceItemFromJson(Map<String, dynamic> json) =>
    VideoSurceItem()
      ..type = (json['type'] as num?)?.toInt()
      ..data = json['data'] == null
          ? null
          : VideoGroupData.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$VideoSurceItemToJson(VideoSurceItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };

VideoGroupData _$VideoGroupDataFromJson(Map<String, dynamic> json) =>
    VideoGroupData()
      ..coverUrl = json['coverUrl'] as String?
      ..height = (json['height'] as num?)?.toDouble()
      ..width = (json['width'] as num?)?.toDouble()
      ..title = json['title'] as String?
      ..description = json['description'] as String?
      ..commentCount = (json['commentCount'] as num?)?.toInt()
      ..shareCount = (json['shareCount'] as num?)?.toInt()
      ..praisedCount = (json['praisedCount'] as num?)?.toInt()
      ..playTime = (json['playTime'] as num?)?.toInt()
      ..creator = json['creator'] == null
          ? null
          : Creator.fromJson(json['creator'] as Map<String, dynamic>)
      ..previewUrl = json['previewUrl'] as String?
      ..vid = json['vid'] as String?
      ..resolutions = (json['resolutions'] as List<dynamic>?)
          ?.map((e) => ResolutionsItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..videoGroup = (json['videoGroup'] as List<dynamic>?)
          ?.map((e) => VideoGroupItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$VideoGroupDataToJson(VideoGroupData instance) =>
    <String, dynamic>{
      'coverUrl': instance.coverUrl,
      'height': instance.height,
      'width': instance.width,
      'title': instance.title,
      'description': instance.description,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'praisedCount': instance.praisedCount,
      'playTime': instance.playTime,
      'creator': instance.creator,
      'previewUrl': instance.previewUrl,
      'vid': instance.vid,
      'resolutions': instance.resolutions,
      'videoGroup': instance.videoGroup,
    };

ResolutionsItem _$ResolutionsItemFromJson(Map<String, dynamic> json) =>
    ResolutionsItem()
      ..size = (json['size'] as num?)?.toInt()
      ..resolution = (json['resolution'] as num?)?.toInt();

Map<String, dynamic> _$ResolutionsItemToJson(ResolutionsItem instance) =>
    <String, dynamic>{
      'size': instance.size,
      'resolution': instance.resolution,
    };

VideoGroupItem _$VideoGroupItemFromJson(Map<String, dynamic> json) =>
    VideoGroupItem()
      ..id = (json['id'] as num?)?.toInt()
      ..name = json['name'] as String?;

Map<String, dynamic> _$VideoGroupItemToJson(VideoGroupItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
