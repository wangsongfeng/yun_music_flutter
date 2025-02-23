import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:yun_music/pages/dynamic_page/models/bu_new_song.dart';
import 'package:yun_music/pages/dynamic_page/models/bu_song_list_info.dart';
import 'package:yun_music/commons/net/init_dio.dart';
import 'package:yun_music/commons/values/server.dart';
import '../commons/models/song_info_dto.dart';
import '../commons/models/song_list_model.dart';
import '../commons/models/song_model.dart';
import '../pages/playlist_detail/models/playlist_detail_model.dart';
import '../vmusic/model/comment_list.dart';
import '../vmusic/model/lyric_info_model.dart';

class BujuanApi {
  //推荐歌单

  static Future<BuSongPlayListWarp> requestPersonPlayList(
      {int offset = 0, int limit = 30}) async {
    var params = {'limit': limit, 'offset': offset, 'n': 1000};
    final metaData = DioMetaData(joinUri('/weapi/personalized/playlist'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);

    final model = BuSongPlayListWarp.fromJson(jsonDecode(response.data));
    return model;
  }

  //推荐新歌
  static Future<BuNewSongListWarp> personalizedSongList() async {
    final metaData = DioMetaData(joinUri('/api/personalized/newsong'),
        data: {'type': 'recommend'}, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    final model = BuNewSongListWarp.fromJson(jsonDecode(response.data));
    return model;
  }

  ///获取歌单详情
  static Future<PlaylistDetailModel?> playListDetail(String categoryId,
      {int subCount = 5}) async {
    var params = {
      'id': categoryId,
      'n': 1000,
      's': '$subCount',
      'shareUserId': '0'
    };
    final metaData = DioMetaData(
        Uri.parse('https://music.163.com/api/v6/playlist/detail'),
        data: params,
        options: joinOptions());
    final response = await httpManager.postUri(metaData);
    final model = PlaylistDetailModel.fromJson(jsonDecode(response.data));
    return model;
  }

  static Future<List<Song>?> getSongsInfo(List<String> songIds) async {
    var params = {
      // 'ids': songIds,
      'c': songIds.map((e) => jsonEncode({'id': e})).toList()
    };
    final metaData = DioMetaData(joinUri('/api/v3/song/detail'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);

    SongListModel? data;
    data = SongListModel.fromJson(jsonDecode(response.data));
    for (final song in data.songs) {
      song.privilege =
          data.privileges.firstWhere((element) => element.id == song.id);
    }

    return data.songs;
  }

  //视频标签列表
  static Future<void> videoGroupList() async {
    final metaData = DioMetaData(joinUri('/api/cloudvideo/group/list'),
        data: {}, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    logger.d('视频标签列表-${response.data['data']}');
  }

  //视频标签下的视频
  static Future<void> videoListByGroup(String groupId,
      {int offset = 0, bool total = true}) async {
    var params = {
      'groupId': groupId,
      'offset': offset,
      'need_preview_url': true,
      'total': total
    };
    final metaData = DioMetaData(joinUri('/api/videotimeline/otherclient/get'),
        data: params, options: joinOptions());

    final response = await httpManager.postUri(metaData);
    logger.d('视频标签下的视频-$response');
  }

  //9B1ADC95792C310437EB48BCF2E622AE
  //相关视频
  static Future<void> relatedVideoList(String videoId) async {
    var params = {
      'id': videoId,
      'type': RegExp(r'^\d+$').hasMatch(videoId) ? 0 : 1
    };
    final metaData = DioMetaData(joinUri('/weapi/cloudvideo/v1/allvideo/rcmd'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    logger.d('相关视频-$response');
  }

  //获取歌曲URL
  static Future<SongInfoListDto> getSongInfo(List<String> songIds,
      {String level = 'exhigh'}) async {
    var params = {
      'ids': songIds,
      'level': level,
      'encodeType': 'flac',
    };
    final metaData = DioMetaData(
        Uri.parse(
            'https://interface.music.163.com/eapi/song/enhance/player/url/v1'),
        data: params,
        options: joinOptions(
            encryptType: EncryptType.EApi,
            eApiUrl: '/api/song/enhance/player/url/v1'));
    final response = await httpManager.postUri(metaData);
    logger.d('音乐信息-${jsonDecode(response.data)}');
    return SongInfoListDto.fromJson(jsonDecode(response.data));
  }

  //获取音乐歌词
  static Future<SongLyricWrap> songLyric(String songId) async {
    var params = {'id': songId, 'lv': -1, 'kv': -1, 'tv': -1};
    final metaData = DioMetaData(joinUri('/api/song/lyric'),
        data: params,
        options:
            joinOptions(encryptType: EncryptType.WeApi, cookies: {'os': 'pc'}));
    final response = await httpManager.postUri(metaData);
    logger.d('音乐歌词-${jsonDecode(response.data)}');
    return SongLyricWrap.fromJson(jsonDecode(response.data));
  }

  //获取评论
  static Future<CommentListWrap?> getSongComment(String id, String type,
      {int pageNo = 1,
      int pageSize = 20,
      bool showInner = false,
      int? sortType,
      String? cursor}) async {
    var params = {
      'threadId': type,
      'pageNo': pageNo,
      'pageSize': pageSize,
      'showInner': showInner,
      'sortType': sortType ?? 99,
      'cursor': cursor,
    };
    final metaData = DioMetaData(joinUri('/api/v2/resource/comments'),
        data: params,
        options: joinOptions(
            encryptType: EncryptType.EApi,
            eApiUrl: '/api/v2/resource/comments',
            cookies: {'os': 'pc'}));
    final response = await httpManager.postUri(metaData);
    return CommentListWrap.fromJson(response.data);
  }

  ///推荐MV
  static Future<void> personalizedMvList() async {
    final metaData = DioMetaData(joinUri('/weapi/personalized/mv'),
        data: {}, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    logger.d(response);
  }

  //网易出品MV
  static Future<void> neteaseMvList(
      {int offset = 0, int limit = 30, bool total = true}) async {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    final metaData = DioMetaData(
        Uri.parse('https://interface.music.163.com/api/mv/exclusive/rcmd'),
        data: params,
        options: joinOptions());
    final response = await httpManager.postUri(metaData);
    logger.d(response);
  }

  //MV详情
  static Future<void> vDetail(String mvId) async {
    var params = {'id': mvId};
    final metaData = DioMetaData(joinUri('/weapi/mv/detail'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    return response.data;
  }

  //相似MV
  static Future<void> mvSimiList(String mvId) async {
    var params = {'mvid': mvId};
    final metaData = DioMetaData(joinUri('/weapi/discovery/simiMV'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    return response.data;
  }

  /// 分类 歌手列表
  static Future<void> artistList(int initial,
      {int offset = 0,
      int limit = 30,
      bool total = true,
      int type = 1,
      int area = -1}) async {
    var params = {
      'initial': initial,
      'type': type,
      'area': area,
      'total': total,
      'limit': limit,
      'offset': offset
    };
    final metaData = DioMetaData(joinUri('/api/v1/artist/list'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    return response.data;
  }
}

// ignore: constant_identifier_names
enum EncryptType { LinuxForward, WeApi, EApi }

Options joinOptions(
        {hookRequestDate = true,
        EncryptType encryptType = EncryptType.WeApi,
        UserAgent userAgent = UserAgent.Random,
        Map<String, String> cookies = const {},
        String eApiUrl = '',
        String? realIP}) =>
    Options(contentType: ContentType.json.value, extra: {
      'hookRequestData': hookRequestDate,
      'encryptType': encryptType,
      'userAgent': userAgent,
      'cookies': cookies,
      'eApiUrl': eApiUrl,
      'realIP': realIP
    });

Uri joinUri(String path) {
  return Uri.parse('$NEW_SERVER_URL$path');
}

// ignore: constant_identifier_names
enum UserAgent { Random, Pc, Mobile }

const userAgentList = [
  'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1',
  'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1',
  'Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Mobile Safari/537.36',
  'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Mobile Safari/537.36',
  'Mozilla/5.0 (Linux; Android 5.1.1; Nexus 6 Build/LYZ28E) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Mobile Safari/537.36',
  'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_2 like Mac OS X) AppleWebKit/603.2.4 (KHTML, like Gecko) Mobile/14F89;GameHelper',
  'Mozilla/5.0 (iPhone; CPU iPhone OS 10_0 like Mac OS X) AppleWebKit/602.1.38 (KHTML, like Gecko) Version/10.0 Mobile/14A300 Safari/602.1',
  'Mozilla/5.0 (iPad; CPU OS 10_0 like Mac OS X) AppleWebKit/602.1.38 (KHTML, like Gecko) Version/10.0 Mobile/14A300 Safari/602.1',
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:46.0) Gecko/20100101 Firefox/46.0',
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36',
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4',
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:46.0) Gecko/20100101 Firefox/46.0',
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36',
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/13.10586'
];
