// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_detail_lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogDetailListsModel _$BlogDetailListsModelFromJson(
        Map<String, dynamic> json) =>
    BlogDetailListsModel(
      count: (json['count'] as num?)?.toInt(),
      code: (json['code'] as num?)?.toInt(),
      programs: (json['programs'] as List<dynamic>?)
          ?.map(
              (e) => BlogDetailProgramItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlogDetailListsModelToJson(
        BlogDetailListsModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'code': instance.code,
      'programs': instance.programs,
    };

BlogDetailProgramItem _$BlogDetailProgramItemFromJson(
        Map<String, dynamic> json) =>
    BlogDetailProgramItem(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      coverUrl: json['coverUrl'] as String?,
      description: json['description'] as String?,
      likedCount: (json['likedCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      listenerCount: (json['listenerCount'] as num?)?.toInt(),
      createTime: (json['createTime'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      secondCategoryId: (json['secondCategoryId'] as num?)?.toInt(),
      radio: json['radio'] == null
          ? null
          : BlogRadios.fromJson(json['radio'] as Map<String, dynamic>),
      scheduledPublishTime: (json['scheduledPublishTime'] as num?)?.toInt(),
      dj: json['dj'] == null
          ? null
          : PersonalizeDJ.fromJson(json['dj'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogDetailProgramItemToJson(
        BlogDetailProgramItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverUrl': instance.coverUrl,
      'description': instance.description,
      'likedCount': instance.likedCount,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'listenerCount': instance.listenerCount,
      'createTime': instance.createTime,
      'categoryId': instance.categoryId,
      'duration': instance.duration,
      'secondCategoryId': instance.secondCategoryId,
      'radio': instance.radio,
      'scheduledPublishTime': instance.scheduledPublishTime,
      'dj': instance.dj,
    };
