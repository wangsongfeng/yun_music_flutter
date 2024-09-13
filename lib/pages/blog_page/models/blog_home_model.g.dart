// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogHomeModel _$BlogHomeModelFromJson(Map<String, dynamic> json) =>
    BlogHomeModel(
      code: (json['code'] as num?)?.toInt(),
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BlogRecomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..banner = (json['banner'] as List<dynamic>?)
          ?.map((e) => BlogBannerModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..personal = (json['personal'] as List<dynamic>?)
          ?.map((e) => BlogPersonalModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$BlogHomeModelToJson(BlogHomeModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'banner': instance.banner,
      'personal': instance.personal,
    };
