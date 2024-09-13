// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_personal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogPersonalModel _$BlogPersonalModelFromJson(Map<String, dynamic> json) =>
    BlogPersonalModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      picUrl: json['picUrl'] as String?,
      subCount: (json['subCount'] as num?)?.toInt(),
      programCount: (json['programCount'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      category: json['category'] as String?,
      secondCategoryId: (json['secondCategoryId'] as num?)?.toInt(),
      secondCategory: json['secondCategory'] as String?,
      dj: json['dj'] == null
          ? null
          : PersonalizeDJ.fromJson(json['dj'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogPersonalModelToJson(BlogPersonalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'picUrl': instance.picUrl,
      'subCount': instance.subCount,
      'programCount': instance.programCount,
      'categoryId': instance.categoryId,
      'category': instance.category,
      'secondCategoryId': instance.secondCategoryId,
      'secondCategory': instance.secondCategory,
      'dj': instance.dj,
    };

PersonalizeDJ _$PersonalizeDJFromJson(Map<String, dynamic> json) =>
    PersonalizeDJ(
      userId: (json['userId'] as num?)?.toInt(),
      userType: (json['userType'] as num?)?.toInt(),
      avatarUrl: json['avatarUrl'] as String?,
      nickname: json['nickname'] as String?,
      backgroundUrl: json['backgroundUrl'] as String?,
      rewardCount: (json['rewardCount'] as num?)?.toInt(),
      followed: json['followed'] as bool?,
      gender: (json['gender'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PersonalizeDJToJson(PersonalizeDJ instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userType': instance.userType,
      'avatarUrl': instance.avatarUrl,
      'nickname': instance.nickname,
      'backgroundUrl': instance.backgroundUrl,
      'rewardCount': instance.rewardCount,
      'followed': instance.followed,
      'gender': instance.gender,
    };
