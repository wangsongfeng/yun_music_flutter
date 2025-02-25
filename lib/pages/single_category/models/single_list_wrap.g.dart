// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_list_wrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleListWrap _$SingleListWrapFromJson(Map<String, dynamic> json) =>
    SingleListWrap()
      ..artists = (json['artists'] as List<dynamic>?)
          ?.map((e) => Singles.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SingleListWrapToJson(SingleListWrap instance) =>
    <String, dynamic>{
      'artists': instance.artists,
    };

Singles _$SinglesFromJson(Map<String, dynamic> json) => Singles()
  ..id = (json['id'] as num?)?.toInt()
  ..accountId = (json['accountId'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..picUrl = json['picUrl'] as String?
  ..img1v1Id = (json['img1v1Id'] as num?)?.toInt()
  ..img1v1Url = json['img1v1Url'] as String?
  ..cover = json['cover'] as String?
  ..albumSize = (json['albumSize'] as num?)?.toInt()
  ..musicSize = (json['musicSize'] as num?)?.toInt()
  ..mvSize = (json['mvSize'] as num?)?.toInt()
  ..topicPerson = (json['topicPerson'] as num?)?.toInt()
  ..trans = json['trans'] as String?
  ..briefDesc = json['briefDesc'] as String?
  ..followed = json['followed'] as bool?
  ..publishTime = (json['publishTime'] as num?)?.toInt()
  ..identityIconUrl = json['identityIconUrl'] as String?
  ..alias = (json['alias'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$SinglesToJson(Singles instance) => <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'name': instance.name,
      'picUrl': instance.picUrl,
      'img1v1Id': instance.img1v1Id,
      'img1v1Url': instance.img1v1Url,
      'cover': instance.cover,
      'albumSize': instance.albumSize,
      'musicSize': instance.musicSize,
      'mvSize': instance.mvSize,
      'topicPerson': instance.topicPerson,
      'trans': instance.trans,
      'briefDesc': instance.briefDesc,
      'followed': instance.followed,
      'publishTime': instance.publishTime,
      'identityIconUrl': instance.identityIconUrl,
      'alias': instance.alias,
    };
