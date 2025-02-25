import 'package:json_annotation/json_annotation.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/pages/single_category/models/single_list_wrap.dart';

import '../../../commons/models/simple_play_list_model.dart';

part 'search_result_wrap.g.dart';

@JsonSerializable()
class SearchResultWrapX extends Object {
  SearchResultWrap? result;
  SearchResultWrapX();
  factory SearchResultWrapX.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchResultWrapXFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchResultWrapXToJson(this);
}

@JsonSerializable()
class SearchResultWrap extends Object {
  SearchComplexSong? song; //单曲
  SearchComplexPlayList? playList; //歌单
  SearchComplexAlbum? album; //专辑
  SearchComplexSingle? artist; //歌手
  List<String>? order;
  SearchResultWrap();

  factory SearchResultWrap.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchResultWrapFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchResultWrapToJson(this);
}

@JsonSerializable()
class SearchComplexSong extends Object {
  List<Song>? songs;
  String? moreText;

  String? highText;

  bool? more;

  List<int>? resourceIds;

  SearchComplexSong();

  factory SearchComplexSong.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchComplexSongFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchComplexSongToJson(this);
}

@JsonSerializable()
class SearchComplexPlayList extends Object {
  List<SimplePlayListModel>? playLists;
  String? moreText;

  String? highText;

  bool? more;

  List<int>? resourceIds;

  SearchComplexPlayList();

  factory SearchComplexPlayList.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchComplexPlayListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchComplexPlayListToJson(this);
}

@JsonSerializable()
class SearchComplexAlbum extends Object {
  List<AlbumSimple>? albums;
  String? moreText;

  String? highText;

  bool? more;

  List<int>? resourceIds;

  SearchComplexAlbum();

  factory SearchComplexAlbum.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchComplexAlbumFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchComplexAlbumToJson(this);
}

@JsonSerializable()
class SearchComplexSingle extends Object {
  List<Singles>? artists;
  String? moreText;

  String? highText;

  bool? more;

  List<int>? resourceIds;

  SearchComplexSingle();

  factory SearchComplexSingle.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchComplexSingleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchComplexSingleToJson(this);
}
