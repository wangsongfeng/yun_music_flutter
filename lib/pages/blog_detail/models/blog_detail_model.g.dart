// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogDetailModel _$BlogDetailModelFromJson(Map<String, dynamic> json) =>
    BlogDetailModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      picUrl: json['picUrl'] as String?,
      desc: json['desc'] as String?,
      subCount: (json['subCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      playCount: (json['playCount'] as num?)?.toInt(),
      category: json['category'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      secondCategory: json['secondCategory'] as String?,
      secondCategoryId: (json['secondCategoryId'] as num?)?.toInt(),
      dj: json['dj'] == null
          ? null
          : PersonalizeDJ.fromJson(json['dj'] as Map<String, dynamic>),
      icon: json['icon'] == null
          ? null
          : BlogIcons.fromJson(json['icon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogDetailModelToJson(BlogDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'desc': instance.desc,
      'subCount': instance.subCount,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'playCount': instance.playCount,
      'category': instance.category,
      'categoryId': instance.categoryId,
      'secondCategory': instance.secondCategory,
      'secondCategoryId': instance.secondCategoryId,
      'dj': instance.dj,
      'icon': instance.icon,
    };
