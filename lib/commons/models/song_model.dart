import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yun_music/commons/models/privilege_model.dart';

import '../../pages/dynamic_page/models/bu_new_song.dart';

part 'song_model.g.dart';

@JsonSerializable()
class Song extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'ar')
  List<Ar> ar;

  @JsonKey(name: 'alia')
  List<String> alia;

  @JsonKey(name: 'fee')
  int fee;

  @JsonKey(name: 'v')
  int v;

  @JsonKey(name: 'st')
  int st;

  @JsonKey(name: 'dt')
  int? dt;

  @JsonKey(name: 'al')
  AlbumSimple al;

  @JsonKey(name: 'copyright')
  int? copyright;

  @JsonKey(name: 'originCoverType')
  int? originCoverType;

  @JsonKey(name: 'mv')
  int? mv;

  @JsonKey(name: 'privilege')
  PrivilegeModel? privilege;

  @JsonKey(name: 'actionType')
  String? actionType;

  @JsonKey(name: 'originSongSimpleData')
  OriginSongSimpleData? originSongSimpleData;

  @JsonKey(name: 'tns')
  List<dynamic>? tns;

  String? reason;

  Song(
    this.name,
    this.id,
    this.ar,
    this.alia,
    this.fee,
    this.v,
    this.al,
    this.copyright,
    this.originCoverType,
    this.mv,
    this.privilege,
    this.actionType,
    this.originSongSimpleData,
    this.st,
    this.dt,
    this.tns,
  );

  factory Song.fromJson(Map<String, dynamic> srcJson) =>
      _$SongFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SongToJson(this);

  String getSongCellSubTitle() {
    final ars =
        ar.map((e) => e.name!).reduce((value, element) => '$value/$element');
    String str = '$ars - ${al.name}';
    if (originSongSimpleData != null) {
      final originArs = originSongSimpleData!.artists
          .map((e) => e.name)
          .reduce((value, element) => '$value/$element');
      str += ' ｜ 原唱：$originArs';
    }
    return str;
  }

  bool canPlay() {
    return true;
    // return st == 0 || st == 1;
  }

  String arString() {
    return ar.map((e) => e.name!).reduce((value, element) => '$value/$element');
  }

  List<int> arIds() {
    return ar.map((e) => e.id).toList();
  }
}

@JsonSerializable()
class Ar extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'tns')
  List<dynamic>? tns;

  @JsonKey(name: 'alias')
  List<dynamic>? alias;

  @JsonKey(name: 'picUrl')
  String? picUrl;

  @JsonKey(name: 'followed')
  bool? followed;

  @JsonKey(name: 'accountId')
  int? accountId;

  @JsonKey(name: 'fansCount')
  int? fansCount;

  Ar(
    this.id,
    this.name,
    this.tns,
    this.alias,
    this.picUrl,
    this.followed,
    this.accountId,
    this.fansCount,
  );

  factory Ar.fromJson(Map<String, dynamic> srcJson) => _$ArFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArToJson(this);

  String? getNameStr() {
    if (GetUtils.isNullOrBlank(alias) == true) return name;
    return '$name(${alias?.map((e) => e.toString()).join('/')})';
  }
}

@JsonSerializable()
class AlbumSimple extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'picUrl')
  String? picUrl;

  @JsonKey(name: 'pic_str')
  String? picStr;
  @JsonKey(name: 'publishTime')
  int? publishTime;
  @JsonKey(name: 'tags')
  String? tags;
  @JsonKey(name: 'copyrightId')
  int? copyrightId;
  @JsonKey(name: 'companyId')
  int? companyId;
  @JsonKey(name: 'company')
  String? company;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'briefDesc')
  String? briefDesc;
  @JsonKey(name: 'artist')
  Artists? artist;
  @JsonKey(name: 'artists')
  List<Artists>? artists;

  AlbumSimple(
      this.id,
      this.name,
      this.picUrl,
      this.picStr,
      this.publishTime,
      this.tags,
      this.copyrightId,
      this.companyId,
      this.company,
      this.description,
      this.briefDesc,
      this.artist,
      this.artists);

  factory AlbumSimple.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumSimpleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumSimpleToJson(this);
}

@JsonSerializable()
class OriginSongSimpleData extends Object {
  @JsonKey(name: 'artists')
  List<Ar> artists;

  OriginSongSimpleData(this.artists);

  factory OriginSongSimpleData.fromJson(Map<String, dynamic> srcJson) =>
      _$OriginSongSimpleDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OriginSongSimpleDataToJson(this);
}
