import 'package:json_annotation/json_annotation.dart';
part 'bu_new_song.g.dart';

@JsonSerializable()
class BuNewSongListWarp extends Object {
  @JsonKey(name: 'result')
  List<BuNewSongList>? result;
  @JsonKey(name: 'category')
  int? category;

  BuNewSongListWarp(
    this.result,
    this.category,
  );
  factory BuNewSongListWarp.fromJson(Map<String, dynamic> srcJson) =>
      _$BuNewSongListWarpFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuNewSongListWarpToJson(this);
}

@JsonSerializable()
class BuNewSongList extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'copywriter')
  String? copywriter;
  @JsonKey(name: 'picUrl')
  String? picUrl;
  @JsonKey(name: 'canDislike')
  bool? canDislike;
  @JsonKey(name: 'trackNumberUpdateTime')
  int? trackNumberUpdateTime;
  @JsonKey(name: 'song')
  BuNewSong? song;

  BuNewSongList({
    this.id,
    this.type,
    this.name,
    this.copywriter,
    this.picUrl,
    this.canDislike,
    this.trackNumberUpdateTime,
  });

  factory BuNewSongList.fromJson(Map<String, dynamic> srcJson) =>
      _$BuNewSongListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuNewSongListToJson(this);
}

@JsonSerializable()
class BuNewSong extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'copyrightId')
  int? copyrightId;
  @JsonKey(name: 'disc')
  String? disc;
  @JsonKey(name: 'no')
  int? no;
  @JsonKey(name: 'fee')
  int? fee;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'starred')
  bool? starred;
  @JsonKey(name: 'starredNum')
  int? starredNum;
  @JsonKey(name: 'popularity')
  double? popularity;
  @JsonKey(name: 'score')
  int? score;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'playedNum')
  int? playedNum;
  @JsonKey(name: 'dayPlays')
  int? dayPlays;
  @JsonKey(name: 'hearTime')
  int? hearTime;
  @JsonKey(name: 'ringtone')
  String? ringtone;
  @JsonKey(name: 'copyFrom')
  String? copyFrom;
  @JsonKey(name: 'commentThreadId')
  String? commentThreadId;
  @JsonKey(name: 'artists')
  List<Artists>? artists;
  @JsonKey(name: 'album')
  NewAlbum? album;
  @JsonKey(name: 'lyrics')
  dynamic lyrics;
  @JsonKey(name: 'privilege')
  Privilege? privilege;
  @JsonKey(name: 'copyright')
  int? copyright;
  @JsonKey(name: 'transName')
  String? transName;
  @JsonKey(name: 'mark')
  int? mark;
  @JsonKey(name: 'rtype')
  int? rtype;
  @JsonKey(name: 'mvid')
  int? mvid;
  @JsonKey(name: 'alg')
  String? alg;
  @JsonKey(name: 'reason')
  String? reason;
  @JsonKey(name: 'hMusic')
  Music? hMusic;
  @JsonKey(name: 'mMusic')
  Music? mMusic;
  @JsonKey(name: 'lMusic')
  Music? lMusic;
  @JsonKey(name: 'bMusic')
  Music? bMusic;

  BuNewSong(
    this.id,
    this.name,
    this.copyrightId,
    this.disc,
    this.no,
    this.fee,
    this.status,
    this.starred,
    this.starredNum,
    this.popularity,
    this.score,
    this.duration,
    this.playedNum,
    this.dayPlays,
    this.hearTime,
    this.ringtone,
    this.copyFrom,
    this.commentThreadId,
    this.artists,
    this.album,
    this.lyrics,
    this.privilege,
    this.transName,
    this.mark,
    this.rtype,
    this.mvid,
    this.alg,
    this.reason,
    this.hMusic,
    this.mMusic,
    this.lMusic,
    this.bMusic,
  );

  factory BuNewSong.fromJson(Map<String, dynamic> srcJson) =>
      _$BuNewSongFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BuNewSongToJson(this);
}

@JsonSerializable()
class Artists extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'accountId')
  String? accountId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'picUrl')
  String? picUrl;
  @JsonKey(name: 'img1v1Id')
  int? img1v1Id;
  @JsonKey(name: 'img1v1Url')
  String? img1v1Url;
  @JsonKey(name: 'cover')
  String? cover;
  @JsonKey(name: 'albumSize')
  int? albumSize;
  @JsonKey(name: 'musicSize')
  int? musicSize;
  @JsonKey(name: 'mvSize')
  int? mvSize;
  @JsonKey(name: 'topicPerson')
  int? topicPerson;
  @JsonKey(name: 'trans')
  String? trans;
  @JsonKey(name: 'briefDesc')
  String? briefDesc;
  @JsonKey(name: 'followed')
  bool? followed;
  @JsonKey(name: 'publishTime')
  int? publishTime;

  Artists(
    this.id,
    this.accountId,
    this.name,
    this.picUrl,
    this.img1v1Id,
    this.img1v1Url,
    this.cover,
    this.albumSize,
    this.musicSize,
    this.mvSize,
    this.topicPerson,
    this.trans,
    this.briefDesc,
    this.followed,
    this.publishTime,
  );

  factory Artists.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtistsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtistsToJson(this);
}

@JsonSerializable()
class NewAlbum extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'subType')
  String? subType;
  @JsonKey(name: 'mark')
  int? mark;
  @JsonKey(name: 'size')
  int? size;
  @JsonKey(name: 'publishTime')
  int? publishTime;
  @JsonKey(name: 'picUrl')
  String? picUrl;
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
  @JsonKey(name: 'isSub')
  bool? isSub;
  @JsonKey(name: 'paid')
  bool? paid;
  @JsonKey(name: 'onSale')
  bool? onSale;

  NewAlbum(
    this.id,
    this.name,
    this.type,
    this.subType,
    this.mark,
    this.size,
    this.publishTime,
    this.picUrl,
    this.tags,
    this.copyrightId,
    this.companyId,
    this.company,
    this.description,
    this.briefDesc,
    this.artist,
    this.artists,
    this.isSub,
    this.paid,
    this.onSale,
  );

  factory NewAlbum.fromJson(Map<String, dynamic> srcJson) =>
      _$NewAlbumFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewAlbumToJson(this);
}

@JsonSerializable()
class Privilege extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'fee')
  int? fee;
  @JsonKey(name: 'payed')
  int? payed;
  @JsonKey(name: 'st')
  int? st;
  @JsonKey(name: 'pl')
  int? pl;
  @JsonKey(name: 'dl')
  int? dl;
  @JsonKey(name: 'sp')
  int? sp;
  @JsonKey(name: 'cp')
  int? cp;
  @JsonKey(name: 'subp')
  int? subp;
  @JsonKey(name: 'cs')
  bool? cs;
  @JsonKey(name: 'maxbr')
  int? maxbr;
  @JsonKey(name: 'fl')
  int? fl;
  @JsonKey(name: 'toast')
  bool? toast;
  @JsonKey(name: 'flag')
  int? flag;
  @JsonKey(name: 'preSell')
  bool? preSell;

  Privilege(
    this.id,
    this.fee,
    this.payed,
    this.st,
    this.pl,
    this.dl,
    this.sp,
    this.cp,
    this.subp,
    this.cs,
    this.maxbr,
    this.fl,
    this.toast,
    this.flag,
    this.preSell,
  );

  factory Privilege.fromJson(Map<String, dynamic> srcJson) =>
      _$PrivilegeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PrivilegeToJson(this);
}

@JsonSerializable()
class Music extends Object {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'size')
  int? size;
  @JsonKey(name: 'extension')
  String? extension;
  @JsonKey(name: 'sr')
  int? sr;
  @JsonKey(name: 'dfsId')
  int? dfsId;
  @JsonKey(name: 'bitrate')
  int? bitrate;
  @JsonKey(name: 'playTime')
  int? playTime;
  @JsonKey(name: 'volumeDelta')
  double? volumeDelta;

  Music(
    this.id,
    this.name,
    this.size,
    this.extension,
    this.sr,
    this.dfsId,
    this.bitrate,
    this.playTime,
    this.volumeDelta,
  );

  factory Music.fromJson(Map<String, dynamic> srcJson) =>
      _$MusicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MusicToJson(this);
}
