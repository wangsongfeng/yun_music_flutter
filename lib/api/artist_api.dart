import 'dart:convert';

import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/values/server.dart';
import 'package:yun_music/pages/single_category/models/single_list_wrap.dart';

import '../commons/net/init_dio.dart';
import '../commons/values/json.dart';
import '../pages/single_category/models/artist_detail_wrap.dart';
import 'bujuan_api.dart';
import 'common_service.dart';

class ArtistApi {
  //获取歌手列表
  static Future<SingleListWrap> artistList(
      {int offset = 0,
      int limit = 30,
      bool total = true,
      int type = 1,
      int area = -1}) async {
    var params = {
      'type': type,
      'area': area,
      'total': total,
      'limit': limit,
      'offset': offset
    };
    final metaData = DioMetaData(joinUri('/api/v1/artist/list'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    // Map<String, dynamic> responseData = jsonDecode(response.data);
    return SingleListWrap.fromJson(jsonDecode(response.data));
  }

  static Future<ArtistDetailData?> requestArtistDetail(
      {required String artistId}) async {
    final metaData = DioMetaData(joinUri('/api/artist/head/info/get'),
        data: {'id': artistId}, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    if (jsonDecode(response.data)["code"] != 200) {
      return null;
    }
    Map<String, dynamic> responseData = jsonDecode(response.data)["data"];
    return ArtistDetailData.fromJson(responseData);
  }

  static Future<void> artistDesc(String artistId) async {
    final metaData = DioMetaData(joinUri('/weapi/artist/introduction'),
        data: {'id': artistId}, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    Map<String, dynamic> responseData = jsonDecode(response.data);
    logger.d(responseData);
  }

  /// 歌手信息+歌曲
  static Future<void> artistDetailAndSongList(String artistId) async {
    // final metaData = DioMetaData(joinUri('/weapi/v1/artist/$artistId'),
    //     data: {'id': artistId}, options: joinOptions());
    // final response = await httpManager.postUri(metaData);
    // Map<String, dynamic> responseData = jsonDecode(response.data);
    // logger.d(responseData);
  }

  ///相似歌手
  static Future<List<Singles>?> artistSimiList(String artistId) async {
    // final metaData = DioMetaData(joinUri('/weapi/discovery/simiArtist'),
    //     data: {'artistid': artistId}, options: joinOptions());
    // final response = await httpManager.postUri(metaData);
    // print(jsonDecode(response.data));

    await Future.delayed(const Duration(milliseconds: 200));
    final localJson =
        await CommonService.jsonDecode(JsonStringConstants.artist_simit);
    final list =
        (localJson['artists'] as List).map((e) => Singles.fromJson(e)).toList();
    return list;
  }

  //歌手全部歌曲
  static Future<List<Song>> artistALLSongList(
    String artistId, {
    bool privateCloud = true,
    int workType = 1,
    order = 'hot',
    int offset = 0,
    int limit = 50,
  }) async {
    var params = {
      'id': artistId,
      'private_cloud': privateCloud,
      'work_type': workType,
      'order': order,
      'limit': limit,
      'offset': offset
    };
    final metaData = DioMetaData(joinUri('/api/v1/artist/songs'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    Map<String, dynamic> responseData = jsonDecode(response.data);
    final list =
        (responseData['songs'] as List).map((e) => Song.fromJson(e)).toList();
    return list;
  }
}
