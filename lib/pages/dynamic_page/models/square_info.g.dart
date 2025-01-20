// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'square_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SquareInfo _$SquareInfoFromJson(Map<String, dynamic> json) => SquareInfo(
      (json['pageNum'] as num?)?.toInt(),
      (json['pageSize'] as num?)?.toInt(),
      (json['size'] as num?)?.toInt(),
      (json['total'] as num?)?.toInt(),
      (json['pages'] as num?)?.toInt(),
      (json['list'] as List<dynamic>?)
          ?.map((e) => SquareList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SquareInfoToJson(SquareInfo instance) =>
    <String, dynamic>{
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'size': instance.size,
      'total': instance.total,
      'pages': instance.pages,
      'list': instance.list,
    };

SquareList _$SquareListFromJson(Map<String, dynamic> json) => SquareList(
      json['weiboId'] as String?,
      json['categoryId'] as String?,
      json['content'] as String?,
      json['vediourl'] as String?,
      json['tail'] as String?,
      (json['createtime'] as num?)?.toInt(),
      (json['zanStatus'] as num?)?.toInt(),
      (json['zhuanfaNum'] as num?)?.toInt(),
      (json['likeNum'] as num?)?.toInt(),
      (json['commentNum'] as num?)?.toInt(),
      json['userInfo'] == null
          ? null
          : SquareUserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      (json['picurl'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['zfContent'] as String?,
      json['zfNick'] as String?,
      json['zfUserId'] as String?,
      (json['zfPicurl'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['zfWeiBoId'] as String?,
      json['zfVedioUrl'] as String?,
      json['containZf'] as bool?,
    );

Map<String, dynamic> _$SquareListToJson(SquareList instance) =>
    <String, dynamic>{
      'weiboId': instance.weiboId,
      'categoryId': instance.categoryId,
      'content': instance.content,
      'vediourl': instance.vediourl,
      'tail': instance.tail,
      'createtime': instance.createtime,
      'zanStatus': instance.zanStatus,
      'zhuanfaNum': instance.zhuanfaNum,
      'likeNum': instance.likeNum,
      'commentNum': instance.commentNum,
      'userInfo': instance.userInfo,
      'picurl': instance.picurl,
      'zfContent': instance.zfContent,
      'zfNick': instance.zfNick,
      'zfUserId': instance.zfUserId,
      'zfPicurl': instance.zfPicurl,
      'zfWeiBoId': instance.zfWeiBoId,
      'zfVedioUrl': instance.zfVedioUrl,
      'containZf': instance.containZf,
    };

SquareUserInfo _$SquareUserInfoFromJson(Map<String, dynamic> json) =>
    SquareUserInfo(
      (json['id'] as num?)?.toInt(),
      json['nick'] as String?,
      json['headurl'] as String?,
      json['decs'] as String?,
      (json['ismember'] as num?)?.toInt(),
      (json['isvertify'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SquareUserInfoToJson(SquareUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
      'headurl': instance.headurl,
      'decs': instance.decs,
      'ismember': instance.ismember,
      'isvertify': instance.isvertify,
    };
