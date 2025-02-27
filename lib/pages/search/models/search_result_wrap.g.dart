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
      ..artist = json['artist'] == null
          ? null
          : SearchComplexSingle.fromJson(json['artist'] as Map<String, dynamic>)
      ..user = json['user'] == null
          ? null
          : SearchComplexUser.fromJson(json['user'] as Map<String, dynamic>)
      ..sim_query = json['sim_query'] == null
          ? null
          : SearchComplexSimQuery.fromJson(
              json['sim_query'] as Map<String, dynamic>)
      ..order =
          (json['order'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$SearchResultWrapToJson(SearchResultWrap instance) =>
    <String, dynamic>{
      'song': instance.song,
      'playList': instance.playList,
      'album': instance.album,
      'artist': instance.artist,
      'user': instance.user,
      'sim_query': instance.sim_query,
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

SearchComplexSingle _$SearchComplexSingleFromJson(Map<String, dynamic> json) =>
    SearchComplexSingle()
      ..artists = (json['artists'] as List<dynamic>?)
          ?.map((e) => Singles.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds = (json['resourceIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList();

Map<String, dynamic> _$SearchComplexSingleToJson(
        SearchComplexSingle instance) =>
    <String, dynamic>{
      'artists': instance.artists,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexUser _$SearchComplexUserFromJson(Map<String, dynamic> json) =>
    SearchComplexUser()
      ..users = (json['users'] as List<dynamic>?)
          ?.map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds = (json['resourceIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList();

Map<String, dynamic> _$SearchComplexUserToJson(SearchComplexUser instance) =>
    <String, dynamic>{
      'users': instance.users,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexSimQuery _$SearchComplexSimQueryFromJson(
        Map<String, dynamic> json) =>
    SearchComplexSimQuery()
      ..sim_querys = (json['sim_querys'] as List<dynamic>)
          .map((e) =>
              SearchComplexSimQueryItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..more = json['more'] as bool?;

Map<String, dynamic> _$SearchComplexSimQueryToJson(
        SearchComplexSimQuery instance) =>
    <String, dynamic>{
      'sim_querys': instance.sim_querys,
      'more': instance.more,
    };
