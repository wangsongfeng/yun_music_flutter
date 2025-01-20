// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hankan_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HankanInfo _$HankanInfoFromJson(Map<String, dynamic> json) => HankanInfo(
      id: json['id'] as String?,
      title: json['title'] as String?,
      poster: json['poster'] as String?,
      poster_small: json['poster_small'] as String?,
      poster_big: json['poster_big'] as String?,
      poster_pc: json['poster_pc'] as String?,
      source_name: json['source_name'] as String?,
      play_url: json['play_url'] as String?,
      playcnt: (json['playcnt'] as num?)?.toInt(),
      mthid: json['mthid'] as String?,
      mthpic: json['mthpic'] as String?,
      threadId: json['threadId'] as String?,
      site_name: json['site_name'] as String?,
      duration: json['duration'] as String?,
      like: (json['like'] as num?)?.toInt(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$HankanInfoToJson(HankanInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster': instance.poster,
      'poster_small': instance.poster_small,
      'poster_big': instance.poster_big,
      'poster_pc': instance.poster_pc,
      'source_name': instance.source_name,
      'play_url': instance.play_url,
      'playcnt': instance.playcnt,
      'mthid': instance.mthid,
      'mthpic': instance.mthpic,
      'threadId': instance.threadId,
      'site_name': instance.site_name,
      'duration': instance.duration,
      'like': instance.like,
      'comment': instance.comment,
    };
