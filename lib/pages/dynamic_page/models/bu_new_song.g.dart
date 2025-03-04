// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bu_new_song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuNewSongListWarp _$BuNewSongListWarpFromJson(Map<String, dynamic> json) =>
    BuNewSongListWarp(
      (json['result'] as List<dynamic>?)
          ?.map((e) => BuNewSongList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['category'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BuNewSongListWarpToJson(BuNewSongListWarp instance) =>
    <String, dynamic>{
      'result': instance.result,
      'category': instance.category,
    };

BuNewSongList _$BuNewSongListFromJson(Map<String, dynamic> json) =>
    BuNewSongList(
      id: (json['id'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      name: json['name'] as String?,
      copywriter: json['copywriter'] as String?,
      picUrl: json['picUrl'] as String?,
      canDislike: json['canDislike'] as bool?,
      trackNumberUpdateTime: (json['trackNumberUpdateTime'] as num?)?.toInt(),
    )..song = json['song'] == null
        ? null
        : BuNewSong.fromJson(json['song'] as Map<String, dynamic>);

Map<String, dynamic> _$BuNewSongListToJson(BuNewSongList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'copywriter': instance.copywriter,
      'picUrl': instance.picUrl,
      'canDislike': instance.canDislike,
      'trackNumberUpdateTime': instance.trackNumberUpdateTime,
      'song': instance.song,
    };

BuNewSong _$BuNewSongFromJson(Map<String, dynamic> json) => BuNewSong(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      (json['copyrightId'] as num?)?.toInt(),
      json['disc'] as String?,
      (json['no'] as num?)?.toInt(),
      (json['fee'] as num?)?.toInt(),
      (json['status'] as num?)?.toInt(),
      json['starred'] as bool?,
      (json['starredNum'] as num?)?.toInt(),
      (json['popularity'] as num?)?.toDouble(),
      (json['score'] as num?)?.toInt(),
      (json['duration'] as num?)?.toInt(),
      (json['playedNum'] as num?)?.toInt(),
      (json['dayPlays'] as num?)?.toInt(),
      (json['hearTime'] as num?)?.toInt(),
      json['ringtone'] as String?,
      json['copyFrom'] as String?,
      json['commentThreadId'] as String?,
      (json['artists'] as List<dynamic>?)
          ?.map((e) => Artists.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['album'] == null
          ? null
          : NewAlbum.fromJson(json['album'] as Map<String, dynamic>),
      json['lyrics'],
      json['privilege'] == null
          ? null
          : Privilege.fromJson(json['privilege'] as Map<String, dynamic>),
      json['transName'] as String?,
      (json['mark'] as num?)?.toInt(),
      (json['rtype'] as num?)?.toInt(),
      (json['mvid'] as num?)?.toInt(),
      json['alg'] as String?,
      json['reason'] as String?,
      json['hMusic'] == null
          ? null
          : Music.fromJson(json['hMusic'] as Map<String, dynamic>),
      json['mMusic'] == null
          ? null
          : Music.fromJson(json['mMusic'] as Map<String, dynamic>),
      json['lMusic'] == null
          ? null
          : Music.fromJson(json['lMusic'] as Map<String, dynamic>),
      json['bMusic'] == null
          ? null
          : Music.fromJson(json['bMusic'] as Map<String, dynamic>),
    )..copyright = (json['copyright'] as num?)?.toInt();

Map<String, dynamic> _$BuNewSongToJson(BuNewSong instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'copyrightId': instance.copyrightId,
      'disc': instance.disc,
      'no': instance.no,
      'fee': instance.fee,
      'status': instance.status,
      'starred': instance.starred,
      'starredNum': instance.starredNum,
      'popularity': instance.popularity,
      'score': instance.score,
      'duration': instance.duration,
      'playedNum': instance.playedNum,
      'dayPlays': instance.dayPlays,
      'hearTime': instance.hearTime,
      'ringtone': instance.ringtone,
      'copyFrom': instance.copyFrom,
      'commentThreadId': instance.commentThreadId,
      'artists': instance.artists,
      'album': instance.album,
      'lyrics': instance.lyrics,
      'privilege': instance.privilege,
      'copyright': instance.copyright,
      'transName': instance.transName,
      'mark': instance.mark,
      'rtype': instance.rtype,
      'mvid': instance.mvid,
      'alg': instance.alg,
      'reason': instance.reason,
      'hMusic': instance.hMusic,
      'mMusic': instance.mMusic,
      'lMusic': instance.lMusic,
      'bMusic': instance.bMusic,
    };

Artists _$ArtistsFromJson(Map<String, dynamic> json) => Artists(
      (json['id'] as num?)?.toInt(),
      json['accountId'] as String?,
      json['name'] as String?,
      json['picUrl'] as String?,
      (json['img1v1Id'] as num?)?.toInt(),
      json['img1v1Url'] as String?,
      json['cover'] as String?,
      (json['albumSize'] as num?)?.toInt(),
      (json['musicSize'] as num?)?.toInt(),
      (json['mvSize'] as num?)?.toInt(),
      (json['topicPerson'] as num?)?.toInt(),
      json['trans'] as String?,
      json['briefDesc'] as String?,
      json['followed'] as bool?,
      (json['publishTime'] as num?)?.toInt(),
      (json['alias'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ArtistsToJson(Artists instance) => <String, dynamic>{
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
      'alias': instance.alias,
    };

NewAlbum _$NewAlbumFromJson(Map<String, dynamic> json) => NewAlbum(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['type'] as String?,
      json['subType'] as String?,
      (json['mark'] as num?)?.toInt(),
      (json['size'] as num?)?.toInt(),
      (json['publishTime'] as num?)?.toInt(),
      json['picUrl'] as String?,
      json['tags'] as String?,
      (json['copyrightId'] as num?)?.toInt(),
      (json['companyId'] as num?)?.toInt(),
      json['company'] as String?,
      json['description'] as String?,
      json['briefDesc'] as String?,
      json['artist'] == null
          ? null
          : Artists.fromJson(json['artist'] as Map<String, dynamic>),
      (json['artists'] as List<dynamic>?)
          ?.map((e) => Artists.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isSub'] as bool?,
      json['paid'] as bool?,
      json['onSale'] as bool?,
    );

Map<String, dynamic> _$NewAlbumToJson(NewAlbum instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'subType': instance.subType,
      'mark': instance.mark,
      'size': instance.size,
      'publishTime': instance.publishTime,
      'picUrl': instance.picUrl,
      'tags': instance.tags,
      'copyrightId': instance.copyrightId,
      'companyId': instance.companyId,
      'company': instance.company,
      'description': instance.description,
      'briefDesc': instance.briefDesc,
      'artist': instance.artist,
      'artists': instance.artists,
      'isSub': instance.isSub,
      'paid': instance.paid,
      'onSale': instance.onSale,
    };

Privilege _$PrivilegeFromJson(Map<String, dynamic> json) => Privilege(
      (json['id'] as num?)?.toInt(),
      (json['fee'] as num?)?.toInt(),
      (json['payed'] as num?)?.toInt(),
      (json['st'] as num?)?.toInt(),
      (json['pl'] as num?)?.toInt(),
      (json['dl'] as num?)?.toInt(),
      (json['sp'] as num?)?.toInt(),
      (json['cp'] as num?)?.toInt(),
      (json['subp'] as num?)?.toInt(),
      json['cs'] as bool?,
      (json['maxbr'] as num?)?.toInt(),
      (json['fl'] as num?)?.toInt(),
      json['toast'] as bool?,
      (json['flag'] as num?)?.toInt(),
      json['preSell'] as bool?,
    );

Map<String, dynamic> _$PrivilegeToJson(Privilege instance) => <String, dynamic>{
      'id': instance.id,
      'fee': instance.fee,
      'payed': instance.payed,
      'st': instance.st,
      'pl': instance.pl,
      'dl': instance.dl,
      'sp': instance.sp,
      'cp': instance.cp,
      'subp': instance.subp,
      'cs': instance.cs,
      'maxbr': instance.maxbr,
      'fl': instance.fl,
      'toast': instance.toast,
      'flag': instance.flag,
      'preSell': instance.preSell,
    };

Music _$MusicFromJson(Map<String, dynamic> json) => Music(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      (json['size'] as num?)?.toInt(),
      json['extension'] as String?,
      (json['sr'] as num?)?.toInt(),
      (json['dfsId'] as num?)?.toInt(),
      (json['bitrate'] as num?)?.toInt(),
      (json['playTime'] as num?)?.toInt(),
      (json['volumeDelta'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MusicToJson(Music instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
      'extension': instance.extension,
      'sr': instance.sr,
      'dfsId': instance.dfsId,
      'bitrate': instance.bitrate,
      'playTime': instance.playTime,
      'volumeDelta': instance.volumeDelta,
    };
