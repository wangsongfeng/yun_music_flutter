// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_list_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) => VideoInfo(
      aweme_id: json['aweme_id'] as String?,
      desc: json['desc'] as String?,
      create_time: (json['create_time'] as num?)?.toInt(),
      music: json['music'] == null
          ? null
          : Music.fromJson(json['music'] as Map<String, dynamic>),
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      share_url: json['share_url'] as String?,
      statistics: json['statistics'] == null
          ? null
          : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      text_extra: (json['text_extra'] as List<dynamic>?)
          ?.map((e) => TextExtra.fromJson(e as Map<String, dynamic>))
          .toList(),
      is_top: (json['is_top'] as num?)?.toInt(),
      share_info: json['share_info'] == null
          ? null
          : ShareInfo.fromJson(json['share_info'] as Map<String, dynamic>),
      duration: (json['duration'] as num?)?.toInt(),
      risk_infos: json['risk_infos'] == null
          ? null
          : RiskInfos.fromJson(json['risk_infos'] as Map<String, dynamic>),
      author_user_id: (json['author_user_id'] as num?)?.toInt(),
      prevent_download: json['prevent_download'] as bool?,
      avatar: json['avatar'] == null
          ? null
          : AvatarInfo.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) => <String, dynamic>{
      'aweme_id': instance.aweme_id,
      'desc': instance.desc,
      'create_time': instance.create_time,
      'music': instance.music,
      'video': instance.video,
      'share_url': instance.share_url,
      'statistics': instance.statistics,
      'status': instance.status,
      'text_extra': instance.text_extra,
      'is_top': instance.is_top,
      'share_info': instance.share_info,
      'duration': instance.duration,
      'risk_infos': instance.risk_infos,
      'author_user_id': instance.author_user_id,
      'prevent_download': instance.prevent_download,
      'avatar': instance.avatar,
    };

Music _$MusicFromJson(Map<String, dynamic> json) => Music(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      author: json['author'] as String?,
      cover_medium: json['cover_medium'] == null
          ? null
          : CoverMedium.fromJson(json['cover_medium'] as Map<String, dynamic>),
      cover_thumb: json['cover_thumb'] == null
          ? null
          : CoverMedium.fromJson(json['cover_thumb'] as Map<String, dynamic>),
      play_url: json['play_url'] == null
          ? null
          : PlayUrl.fromJson(json['play_url'] as Map<String, dynamic>),
      duration: (json['duration'] as num?)?.toInt(),
      user_count: (json['user_count'] as num?)?.toInt(),
      owner_nickname: json['owner_nickname'] as String?,
      is_original: json['is_original'] as bool?,
    );

Map<String, dynamic> _$MusicToJson(Music instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'cover_medium': instance.cover_medium,
      'cover_thumb': instance.cover_thumb,
      'play_url': instance.play_url,
      'duration': instance.duration,
      'user_count': instance.user_count,
      'owner_nickname': instance.owner_nickname,
      'is_original': instance.is_original,
    };

CoverMedium _$CoverMediumFromJson(Map<String, dynamic> json) => CoverMedium(
      uri: json['uri'] as String?,
      url_list: (json['url_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CoverMediumToJson(CoverMedium instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'url_list': instance.url_list,
      'width': instance.width,
      'height': instance.height,
    };

PlayUrl _$PlayUrlFromJson(Map<String, dynamic> json) => PlayUrl(
      uri: json['uri'] as String?,
      url_list: (json['url_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      url_key: json['url_key'] as String?,
    );

Map<String, dynamic> _$PlayUrlToJson(PlayUrl instance) => <String, dynamic>{
      'uri': instance.uri,
      'url_list': instance.url_list,
      'width': instance.width,
      'height': instance.height,
      'url_key': instance.url_key,
    };

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      play_addr: json['play_addr'] == null
          ? null
          : PlayAddr.fromJson(json['play_addr'] as Map<String, dynamic>),
      cover: json['cover'] == null
          ? null
          : CoverMedium.fromJson(json['cover'] as Map<String, dynamic>),
      poster: json['poster'] as String?,
      height: (json['height'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      ratio: json['ratio'] as String?,
      use_static_cover: json['use_static_cover'] as bool?,
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'play_addr': instance.play_addr,
      'cover': instance.cover,
      'poster': instance.poster,
      'height': instance.height,
      'width': instance.width,
      'ratio': instance.ratio,
      'use_static_cover': instance.use_static_cover,
      'duration': instance.duration,
    };

PlayAddr _$PlayAddrFromJson(Map<String, dynamic> json) => PlayAddr(
      uri: json['uri'] as String?,
      url_list: (json['url_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      url_key: json['url_key'] as String?,
      data_size: (json['data_size'] as num?)?.toInt(),
      file_hash: json['file_hash'] as String?,
      file_cs: json['file_cs'] as String?,
    );

Map<String, dynamic> _$PlayAddrToJson(PlayAddr instance) => <String, dynamic>{
      'uri': instance.uri,
      'url_list': instance.url_list,
      'width': instance.width,
      'height': instance.height,
      'url_key': instance.url_key,
      'data_size': instance.data_size,
      'file_hash': instance.file_hash,
      'file_cs': instance.file_cs,
    };

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
      admire_count: (json['admire_count'] as num?)?.toInt(),
      comment_count: (json['comment_count'] as num?)?.toInt(),
      digg_count: (json['digg_count'] as num?)?.toInt(),
      collect_count: (json['collect_count'] as num?)?.toInt(),
      play_count: (json['play_count'] as num?)?.toInt(),
      share_count: (json['share_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'admire_count': instance.admire_count,
      'comment_count': instance.comment_count,
      'digg_count': instance.digg_count,
      'collect_count': instance.collect_count,
      'play_count': instance.play_count,
      'share_count': instance.share_count,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      listen_video_status: (json['listen_video_status'] as num?)?.toInt(),
      is_delete: json['is_delete'] as bool?,
      allow_share: json['allow_share'] as bool?,
      is_prohibited: json['is_prohibited'] as bool?,
      in_reviewing: json['in_reviewing'] as bool?,
      part_see: (json['part_see'] as num?)?.toInt(),
      private_status: (json['private_status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'listen_video_status': instance.listen_video_status,
      'is_delete': instance.is_delete,
      'allow_share': instance.allow_share,
      'is_prohibited': instance.is_prohibited,
      'in_reviewing': instance.in_reviewing,
      'part_see': instance.part_see,
      'private_status': instance.private_status,
    };

ShareInfo _$ShareInfoFromJson(Map<String, dynamic> json) => ShareInfo(
      share_url: json['share_url'] as String?,
      share_link_desc: json['share_link_desc'] as String?,
    );

Map<String, dynamic> _$ShareInfoToJson(ShareInfo instance) => <String, dynamic>{
      'share_url': instance.share_url,
      'share_link_desc': instance.share_link_desc,
    };

RiskInfos _$RiskInfosFromJson(Map<String, dynamic> json) => RiskInfos(
      vote: json['vote'] as bool?,
      warn: json['warn'] as bool?,
      risk_sink: json['risk_sink'] as bool?,
      type: (json['type'] as num?)?.toInt(),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$RiskInfosToJson(RiskInfos instance) => <String, dynamic>{
      'vote': instance.vote,
      'warn': instance.warn,
      'risk_sink': instance.risk_sink,
      'type': instance.type,
      'content': instance.content,
    };

TextExtra _$TextExtraFromJson(Map<String, dynamic> json) => TextExtra(
      start: (json['start'] as num?)?.toInt(),
      end: (json['end'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      hashtag_name: json['hashtag_name'] as String?,
      hashtag_id: json['hashtag_id'] as String?,
      is_commerce: json['is_commerce'] as bool?,
      caption_start: (json['caption_start'] as num?)?.toInt(),
      caption_end: (json['caption_end'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TextExtraToJson(TextExtra instance) => <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'type': instance.type,
      'hashtag_name': instance.hashtag_name,
      'hashtag_id': instance.hashtag_id,
      'is_commerce': instance.is_commerce,
      'caption_start': instance.caption_start,
      'caption_end': instance.caption_end,
    };
