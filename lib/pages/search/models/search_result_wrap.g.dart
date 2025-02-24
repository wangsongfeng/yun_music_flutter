// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_wrap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultWrapX _$SearchResultWrapXFromJson(Map<String, dynamic> json) =>
    SearchResultWrapX()
      ..result = json['result'] == null
          ? null
          : SearchResultWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchResultWrapXToJson(SearchResultWrapX instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

SearchResultWrap _$SearchResultWrapFromJson(Map<String, dynamic> json) =>
    SearchResultWrap()
      ..song = json['song'] == null
          ? null
          : SearchComplexSong.fromJson(json['song'] as Map<String, dynamic>)
      ..playList = json['playList'] == null
          ? null
          : SearchComplexPlayList.fromJson(
              json['playList'] as Map<String, dynamic>)
      ..album = json['album'] == null
          ? null
          : SearchComplexAlbum.fromJson(json['album'] as Map<String, dynamic>)
      ..order =
          (json['order'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$SearchResultWrapToJson(SearchResultWrap instance) =>
    <String, dynamic>{
      'song': instance.song,
      'playList': instance.playList,
      'album': instance.album,
      'order': instance.order,
    };

SearchComplexSong _$SearchComplexSongFromJson(Map<String, dynamic> json) =>
    SearchComplexSong()
      ..songs = (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds = (json['resourceIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList();

Map<String, dynamic> _$SearchComplexSongToJson(SearchComplexSong instance) =>
    <String, dynamic>{
      'songs': instance.songs,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexPlayList _$SearchComplexPlayListFromJson(
        Map<String, dynamic> json) =>
    SearchComplexPlayList()
      ..playLists = (json['playLists'] as List<dynamic>?)
          ?.map((e) => SimplePlayListModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds = (json['resourceIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList();

Map<String, dynamic> _$SearchComplexPlayListToJson(
        SearchComplexPlayList instance) =>
    <String, dynamic>{
      'playLists': instance.playLists,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexAlbum _$SearchComplexAlbumFromJson(Map<String, dynamic> json) =>
    SearchComplexAlbum()
      ..albums = (json['albums'] as List<dynamic>?)
          ?.map((e) => AlbumSimple.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds = (json['resourceIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList();

Map<String, dynamic> _$SearchComplexAlbumToJson(SearchComplexAlbum instance) =>
    <String, dynamic>{
      'albums': instance.albums,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };
