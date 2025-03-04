// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_detail_wrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistDetailData _$ArtistDetailDataFromJson(Map<String, dynamic> json) =>
    ArtistDetailData()
      ..videoCount = (json['videoCount'] as num?)?.toInt()
      ..identify = json['identify'] == null
          ? null
          : ArtistDetailIdentify.fromJson(
              json['identify'] as Map<String, dynamic>)
      ..artist = json['artist'] == null
          ? null
          : Artists.fromJson(json['artist'] as Map<String, dynamic>)
      ..blacklist = json['blacklist'] as bool?
      ..preferShow = (json['preferShow'] as num?)?.toInt()
      ..showPriMsg = json['showPriMsg'] as bool?
      ..user = json['user'] == null
          ? null
          : UserInfo.fromJson(json['user'] as Map<String, dynamic>)
      ..secondaryExpertIdentiy =
          (json['secondaryExpertIdentiy'] as List<dynamic>?)
              ?.map((e) =>
                  ArtistDetailSecondIdentiy.fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$ArtistDetailDataToJson(ArtistDetailData instance) =>
    <String, dynamic>{
      'videoCount': instance.videoCount,
      'identify': instance.identify,
      'artist': instance.artist,
      'blacklist': instance.blacklist,
      'preferShow': instance.preferShow,
      'showPriMsg': instance.showPriMsg,
      'user': instance.user,
      'secondaryExpertIdentiy': instance.secondaryExpertIdentiy,
    };

ArtistDetailIdentify _$ArtistDetailIdentifyFromJson(
        Map<String, dynamic> json) =>
    ArtistDetailIdentify()
      ..imageUrl = json['imageUrl'] as String?
      ..imageDesc = json['imageDesc'] as String?
      ..actionUrl = json['actionUrl'] as String?;

Map<String, dynamic> _$ArtistDetailIdentifyToJson(
        ArtistDetailIdentify instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'imageDesc': instance.imageDesc,
      'actionUrl': instance.actionUrl,
    };

ArtistDetailSecondIdentiy _$ArtistDetailSecondIdentiyFromJson(
        Map<String, dynamic> json) =>
    ArtistDetailSecondIdentiy()
      ..expertIdentiyId = (json['expertIdentiyId'] as num?)?.toInt()
      ..expertIdentiyName = json['expertIdentiyName'] as String?
      ..expertIdentiyCount = (json['expertIdentiyCount'] as num?)?.toInt();

Map<String, dynamic> _$ArtistDetailSecondIdentiyToJson(
        ArtistDetailSecondIdentiy instance) =>
    <String, dynamic>{
      'expertIdentiyId': instance.expertIdentiyId,
      'expertIdentiyName': instance.expertIdentiyName,
      'expertIdentiyCount': instance.expertIdentiyCount,
    };
