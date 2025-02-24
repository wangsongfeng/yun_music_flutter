import 'package:json_annotation/json_annotation.dart';
import 'package:yun_music/commons/models/privilege_model.dart';
import 'package:yun_music/commons/models/song_model.dart';

part 'recom_new_song.g.dart';

@JsonSerializable()
class RecomNewSong extends Object {
  @JsonKey(name: 'songData')
  SongData songData;

  @JsonKey(name: 'songPrivilege')
  PrivilegeModel songPrivilege;

  RecomNewSong(
    this.songData,
    this.songPrivilege,
  );

  factory RecomNewSong.fromJson(Map<String, dynamic> srcJson) =>
      _$RecomNewSongFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecomNewSongToJson(this);

  Song buildSong(String? type) {
    return Song(
        songData.name,
        songData.id,
        songData.artists,
        songData.alias,
        songData.fee,
        100,
        songData.album,
        songData.copyright,
        songData.originCoverType,
        songData.mvid,
        songPrivilege,
        type,
        null,
        1,
        0, []);
  }
}

@JsonSerializable()
class SongData extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'fee')
  int fee;

  @JsonKey(name: 'copyright')
  int? copyright;

  @JsonKey(name: 'originCoverType')
  int? originCoverType;

  @JsonKey(name: 'mvid')
  int mvid;

  @JsonKey(name: 'alias')
  List<String> alias;

  @JsonKey(name: 'artists')
  List<Ar> artists;

  @JsonKey(name: 'album')
  AlbumSimple album;

  @JsonKey(name: 'privilege')
  PrivilegeModel? songPrivilege;

  SongData(this.name, this.id, this.fee, this.copyright, this.originCoverType,
      this.mvid, this.alias, this.artists, this.album, this.songPrivilege);

  factory SongData.fromJson(Map<String, dynamic> srcJson) =>
      _$SongDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongDataToJson(this);

  Song buildSong() {
    return Song(name, id, artists, alias, fee, 100, album, copyright,
        originCoverType, mvid, songPrivilege, null, null, 0, 0, []);
  }
}
