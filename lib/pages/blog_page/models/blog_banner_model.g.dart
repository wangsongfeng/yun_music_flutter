// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogBannerModel _$BlogBannerModelFromJson(Map<String, dynamic> json) =>
    BlogBannerModel(
      targetId: (json['targetId'] as num?)?.toInt(),
      targetType: (json['targetType'] as num?)?.toInt(),
      pic: json['pic'] as String?,
      url: json['url'] as String?,
      typeTitle: json['typeTitle'] as String?,
      exclusive: json['exclusive'] as bool?,
    );

Map<String, dynamic> _$BlogBannerModelToJson(BlogBannerModel instance) =>
    <String, dynamic>{
      'targetId': instance.targetId,
      'targetType': instance.targetType,
      'pic': instance.pic,
      'url': instance.url,
      'typeTitle': instance.typeTitle,
      'exclusive': instance.exclusive,
    };
