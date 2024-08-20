import 'package:get/get.dart';
import 'package:yun_music/api/common_service.dart';
import 'package:yun_music/commons/models/remd_song_daily_model.dart';
import 'package:yun_music/commons/net/init_dio.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/commons/values/json.dart';
import 'package:yun_music/pages/playlist_collection/model/plsy_list_tag_model.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../commons/models/simple_play_list_model.dart';
import '../pages/playlist_collection/model/playlist_has_more_model.dart';

class MusicApi {
  //获取首页内容
  static Future<RecomModel?> getRecomRec(
      {bool refresh = false, Map<String, dynamic>? cacheData}) async {
    // RecomModel? oldData;
    // if (cacheData != null) {
    //   oldData = RecomModel.fromJson(cacheData);
    // }

    // final response = await httpManager.get("/homepage/block/page", {
    //   'refresh': refresh,
    //   'cursor': oldData?.cursor ?? '',
    //   'timestamp': DateTime.now().millisecondsSinceEpoch
    // });

    // if (response.result) {
    //   try {
    //     final recmData = RecomModel.fromJson(response.data['data']);
    //     final responseBall =
    //         await httpManager.get("/homepage/dragon/ball", null);
    //     //缓存数字专辑Url
    //     final url = box.read(CACHE_ALBUM_POLY_DETAIL_URL);
    //     if (GetUtils.isNullOrBlank(url) == true) {
    //       (responseBall.data['data'] as List)
    //           .map((e) => Ball.fromJson(e))
    //           .toList()
    //           .forEach((element) {
    //         if (element.id == 13000) {
    //           box.write(CACHE_ALBUM_POLY_DETAIL_URL, element.url);
    //         }
    //       });
    //     }
    //     recmData.blocks.insert(
    //         1,
    //         Blocks("HOMEPAGE_BALL", SHOWTYPE_BALL, responseBall.data['data'],
    //             null, null, false));
    //     return _diffData(recmData, oldData);
    //   } catch (e) {
    //     print('请求失败');
    //     e.printError();
    //   }
    // }

    //请求失败，加载本地json
    final recomJson =
        await CommonService.jsonDecode(JsonStringConstants.discover_pages);
    final recmData = RecomModel.fromJson(recomJson['data']);
    final ballJson =
        await CommonService.jsonDecode(JsonStringConstants.discover_balls);
    recmData.blocks.insert(
        1,
        Blocks("HOMEPAGE_BALL", SHOWTYPE_BALL, ballJson['data'], null, null,
            false));
    return recmData;
  }

  static Future<RecomModel?> _diffData(
      RecomModel recmData, RecomModel? oldData) async {
    if (oldData == null || recmData.blocks.length > oldData.blocks.length) {
      box.write(CACHE_HOME_RECOMMEND_DATA, recmData.toJson());
      return Future.value(recmData);
    } else {
      ///有缓存过数据 进行比较差量更新
      final List<Blocks> diffList = List.empty(growable: true);

      final newBlocks = recmData.blocks;

      for (final old in oldData.blocks) {
        final index = newBlocks
            .indexWhere((element) => element.blockCode == old.blockCode);
        if (index != -1) {
          //新的数据包含旧的数据 替换旧的数据
          diffList.add(newBlocks.elementAt(index));
        } else {
          //新的数据不包含旧的数据 用换旧的数据
          diffList.add(old);
        }
      }
      //组装新的展示数据
      final newData =
          RecomModel(recmData.cursor, diffList, recmData.pageConfig);
      box.write(CACHE_HOME_RECOMMEND_DATA, newData.toJson());
      return Future.value(newData);
    }
  }

  ///获取每日推荐
  static Future<RcmdSongDailyModel?> getRcmdSongs() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return CommonService.jsonDecode(JsonStringConstants.recommend_songs)
        .then((value) {
      return RcmdSongDailyModel.fromJson(value['data']);
    });
    // final response = await httpManager.get('/recommend/songs', null);
    // if (response.result) {
    //   return RcmdSongDailyModel.fromJson(response.data['data']);
    // } else {

    // }
    // return null;
  }

  //获取歌单标签
  static Future<List<PlayListTagModel>?> getHotTags() async {
    List<PlayListTagModel>? data;
    // final response = await httpManager.get('/playlist/hot', null);
    // if (response.result) {
    //   data = (response.data['tags'] as List)
    //       .map((e) => PlayListTagModel.fromJson(e))
    //       .toList();
    // } else {
    //   final localJson = await CommonService.jsonDecode(
    //       JsonStringConstants.playlist_collection_tags);
    //   data = (localJson['tags'] as List)
    //       .map((e) => PlayListTagModel.fromJson(e))
    //       .toList();
    // }
    await Future.delayed(const Duration(milliseconds: 500));
    final localJson = await CommonService.jsonDecode(
        JsonStringConstants.playlist_collection_tags);
    data = (localJson['tags'] as List)
        .map((e) => PlayListTagModel.fromJson(e))
        .toList();
    return data;
  }

  ///推荐歌单列表不支持分页
  static Future<PlaylistHasMoreModel?> getRcmPlayList() async {
    final response = await httpManager.get('/personalized',
        {"limit": 99, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    PlaylistHasMoreModel? data;
    if (response.result) {
      final list = (response.data['result'] as List)
          .map((e) => SimplePlayListModel.fromJson(e))
          .toList();
      data = PlaylistHasMoreModel(datas: list, totalCount: response.total);
    }
    return data;
  }

  //获取精选歌单
  static Future<PlaylistHasMoreModel?> getPlayListFromTag(
    String tag,
    int limit,
    int offset,
  ) async {
    final response = await httpManager.get('/top/playlist', {
      'cat': tag,
      'limit': limit,
      'offset': offset,
    });
    PlaylistHasMoreModel? data;
    if (response.result) {
      final list = (response.data['playlists'] as List)
          .map((e) => SimplePlayListModel.fromJson(e))
          .toList();
      data =
          PlaylistHasMoreModel(datas: list, totalCount: response.data['total']);
    }

    return data;
  }

  ///获取精品歌单标签列表
  static Future<List<String>?> getHighqualityTags() async {
    final response = await httpManager.get('/playlist/highquality/tags', null);
    List<String>? tags;
    if (response.result) {
      tags = (response.data['tags'] as List)
          .map((e) => e['name'].toString())
          .toList();
    }
    return tags;
  }

  ///获取精品歌单
  static Future<PlaylistHasMoreModel?> getHighqualityList(
    String? tag,
    int limit,
    int? before,
  ) async {
    final par = {"limit": limit.toString()};
    par.addIf(before != null, 'before', before.toString());
    par.addIf(tag != null, "cat", tag.toString());
    final response = await httpManager.get('/top/playlist/highquality', par);
    PlaylistHasMoreModel? data;
    if (response.result) {
      final list = (response.data['playlists'] as List)
          .map((e) => SimplePlayListModel.fromJson(e))
          .toList();
      data =
          PlaylistHasMoreModel(datas: list, totalCount: response.data['total']);
    }
    return data;
  }
}
