import 'package:get/get.dart';
import 'package:yun_music/api/common_service.dart';
import 'package:yun_music/commons/models/mine_music_list.dart';
import 'package:yun_music/commons/models/remd_song_daily_model.dart';
import 'package:yun_music/commons/models/song_list_model.dart';
import 'package:yun_music/commons/net/init_dio.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/commons/values/json.dart';
import 'package:yun_music/pages/blog_page/models/blog_banner_model.dart';
import 'package:yun_music/pages/blog_page/models/blog_personal_model.dart';
import 'package:yun_music/pages/playlist_collection/model/plsy_list_tag_model.dart';
import 'package:yun_music/pages/rank_list/models/ranklist_item.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';
import 'package:yun_music/pages/recommend/models/recom_new_song.dart';
import 'package:yun_music/pages/village/models/video_category.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/video/models/avatar_info.dart';
import 'package:yun_music/video/models/hankan_info.dart';
import 'package:yun_music/video/models/hishort_info.dart';
import 'package:yun_music/video/models/video_list_info.dart';

import '../commons/models/simple_play_list_model.dart';
import '../commons/models/song_info_dto.dart';
import '../commons/models/song_model.dart';
import '../pages/blog_detail/models/blog_detail_lists.dart';
import '../pages/blog_detail/models/blog_detail_model.dart';
import '../pages/blog_page/models/blog_home_model.dart';
import '../pages/dynamic_page/models/square_info.dart';
import '../pages/new_song_album/models/album_cover_info.dart';
import '../pages/new_song_album/models/top_album_cover_info.dart';
import '../pages/new_song_album/models/top_album_model.dart';
import '../pages/playlist_collection/model/playlist_has_more_model.dart';
import '../pages/playlist_detail/models/playlist_detail_model.dart';
import '../pages/village/models/video_group.dart';
import 'bujuan_api.dart';

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
    // return null;
    RecomModel? oldData;
    if (cacheData != null) {
      oldData = RecomModel.fromJson(cacheData);
    }
    var params = {
      'refresh': refresh,
      'cursor': oldData?.cursor ?? '',
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    final metaData = DioMetaData(joinUri('/weapi/homepage/block/page'),
        data: params, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    final recmModelWrap = RecomModelWrap.fromJson(response.data);
    final recmData = recmModelWrap.data!;
    final ballJson =
        await CommonService.jsonDecode(JsonStringConstants.discover_balls);
    recmData.blocks.insert(
        1,
        Blocks("HOMEPAGE_BALL", SHOWTYPE_BALL, ballJson['data'], null, null,
            false));
    return _diffData(recmData, oldData);

    //请求失败，加载本地json
    // final recomJson =
    //     await CommonService.jsonDecode(JsonStringConstants.discover_pages);
    // final recmData = RecomModel.fromJson(recomJson['data']);
    // final ballJson =
    //     await CommonService.jsonDecode(JsonStringConstants.discover_balls);
    // recmData.blocks.insert(
    //     1,
    //     Blocks("HOMEPAGE_BALL", SHOWTYPE_BALL, ballJson['data'], null, null,
    //         false));
    // return recmData;
  }

  // ignore: unused_element
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
    await Future.delayed(const Duration(milliseconds: 200));
    return CommonService.jsonDecode(JsonStringConstants.recommend_songs)
        .then((value) {
      return RcmdSongDailyModel.fromJson(value['data']);
    });
    // final response = await httpManager.get('/recommend/songs', null);
    // if (response.result) {
    //   return RcmdSongDailyModel.fromJson(response.data['data']);
    // } else {}
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
    await Future.delayed(const Duration(milliseconds: 200));
    final localJson = await CommonService.jsonDecode(
        JsonStringConstants.playlist_collection_tags);
    data = (localJson['tags'] as List)
        .map((e) => PlayListTagModel.fromJson(e))
        .toList();
    return data;
  }

  ///推荐歌单列表不支持分页 https://netease-cloud-music-api-masterxing.vercel.app/personalized
  static Future<PlaylistHasMoreModel?> getRcmPlayList() async {
    // final response = await httpManager.get('/personalized',
    //     {"limit": 99, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    // PlaylistHasMoreModel? data;
    // if (response.result) {
    //   final list = (response.data['result'] as List)
    //       .map((e) => SimplePlayListModel.fromJson(e))
    //       .toList();
    //   data = PlaylistHasMoreModel(datas: list, totalCount: response.total);
    // }
    // return data;

    PlaylistHasMoreModel? data;
    await Future.delayed(const Duration(milliseconds: 200));
    final localJson = await CommonService.jsonDecode(
        JsonStringConstants.playlist_collection_recom);
    final list = (localJson['result'] as List)
        .map((e) => SimplePlayListModel.fromJson(e))
        .toList();
    data = PlaylistHasMoreModel(datas: list, totalCount: list.length);

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

  ///歌单详情 https://netease-cloud-music-api-masterxing.vercel.app/playlist/detail?id=2219770152&s=5
  static Future<PlaylistDetailModel?> getPlaylistDetail(String id) async {
    // final response = await httpManager.get('/playlist/detail', {
    //   'id': id,
    //   's': '5',
    //   'timestamp': DateTime.now().millisecondsSinceEpoch
    // });
    // PlaylistDetailModel? data;
    // if (response.result) {
    //   data = PlaylistDetailModel.fromJson(response.data);
    // }
    // return data;

    PlaylistDetailModel? data;
    await Future.delayed(const Duration(milliseconds: 200));
    final localJson = await CommonService.jsonDecode(
        JsonStringConstants.playlist_detail_single);
    data = PlaylistDetailModel.fromJson(localJson);
    return data;
  }

  ///获取歌曲详情 多个逗号隔开
  static Future<List<Song>?> getSongsInfo(String ids) async {
    // final response =
    //     await httpManager.get('/song/detail', Map.of({'ids': ids}));
    // SongListModel? data;
    // if (response.result) {
    //   data = SongListModel.fromJson(response.data);
    //   for (final song in data.songs) {
    //     song.privilege =
    //         data.privileges.firstWhere((element) => element.id == song.id);
    //   }
    // }
    // return data?.songs;

    SongListModel? data;

    await Future.delayed(const Duration(milliseconds: 200));
    final localJson = await CommonService.jsonDecode(
        JsonStringConstants.playlist_detail_songs);
    data = SongListModel.fromJson(localJson);
    for (final song in data.songs) {
      song.privilege =
          data.privileges.firstWhere((element) => element.id == song.id);
    }

    return data.songs;
  }

  ///获取歌单详情里边的歌曲数据

  ///获取排行榜 https://netease-cloud-music-api-masterxing.vercel.app/toplist/detail
  static Future<List<RanklistItem>> getRankList() async {
    // final response = await httpManager.get('/toplist/detail', null);
    // if (response.isSuccess()) {
    //   return (response.data['list'] as List)
    //       .map((e) => RanklistItem.fromJson(e))
    //       .toList();
    // }
    // return List.empty();

    await Future.delayed(const Duration(milliseconds: 200));
    final localJson =
        await CommonService.jsonDecode(JsonStringConstants.ranklist_songs);
    final list = (localJson['list'] as List)
        .map((e) => RanklistItem.fromJson(e))
        .toList();
    return list;
  }

  ///获取推荐新歌 https://netease-cloud-music-api-masterxing.vercel.app/personalized/newsong?limit=50
  static Future<List<Song>?> getRecmNewSongs() async {
    // final response =
    //     await httpManager.get('/personalized/newsong', {'limit': 50});
    // if (response.result) {
    //   final list = response.data['result'] as List;
    //   return list.map((e) => SongData.fromJson(e['song']).buildSong()).toList();
    // }
    // return null;

    await Future.delayed(const Duration(milliseconds: 200));
    final localJson =
        await CommonService.jsonDecode(JsonStringConstants.new_song_recom);
    final list = (localJson['result'] as List);
    return list.map((e) => SongData.fromJson(e['song']).buildSong()).toList();
  }

  ///根据tag获取新歌 https://netease-cloud-music-api-masterxing.vercel.app/top/song?type=0
  static Future<List<Song>?> getNewSongFromTag(int tag) async {
    // final response = await httpManager.get('/top/song', {'type': tag});
    // if (response.result) {
    //   return (response.data['data'] as List)
    //       .map((e) => SongData.fromJson(e).buildSong())
    //       .toList();
    // }
    // return null;
    await Future.delayed(const Duration(milliseconds: 200));
    final localJson =
        await CommonService.jsonDecode(JsonStringConstants.new_song_all);
    final list = (localJson['data'] as List);
    return list.map((e) => SongData.fromJson(e).buildSong()).toList();
  }

  ///获取最新数字专辑 https://netease-cloud-music-api-masterxing.vercel.app/album/list?limit=3
  static Future<List<AlbumCoverInfo>?> getNewAlbum({int limit = 3}) async {
    // final response = await httpManager.get('/album/list', {'limit': limit});
    // if (response.result) {
    //   return (response.data['products'] as List)
    //       .map((e) => AlbumCoverInfo.fromJson(e))
    //       .toList();
    // }
    // return null;

    await Future.delayed(const Duration(milliseconds: 200));
    final localJson =
        await CommonService.jsonDecode(JsonStringConstants.new_album_news);
    final list = (localJson['products'] as List);
    return list.map((e) => AlbumCoverInfo.fromJson(e)).toList();
  }

  ///获取新碟上架列表 https://netease-cloud-music-api-masterxing.vercel.app/top/album
  static Future<List<TopAlbumModel>> getTopAlbum(int year, int month,
      {List<TopAlbumModel>? oldData}) async {
    // final response =
    //     await httpManager.get('/top/album', {'year': year, 'month': month});
    // final resultData = List<TopAlbumModel>.empty(growable: true);
    // if (oldData != null) {
    //   resultData.addAll(oldData);
    // }
    // if (response.result) {
    //   final weekData = response.data['weekData'];
    //   final monthData = response.data['monthData'];
    //   if (weekData != null) {
    //     final list = (weekData as List)
    //         .map((e) => TopAlbumCoverInfo.fromJson(e))
    //         .toList();
    //     resultData.add(TopAlbumModel(label: '本周新碟', data: list));
    //   }
    //   if (monthData != null) {
    //     final list = (monthData as List)
    //         .map((e) => TopAlbumCoverInfo.fromJson(e))
    //         .toList();
    //     resultData
    //         .add(TopAlbumModel(dateTime: DateTime(year, month), data: list));
    //   }
    // }
    // return resultData;

    await Future.delayed(const Duration(milliseconds: 200));
    final localJson =
        await CommonService.jsonDecode(JsonStringConstants.new_album_tops);
    final resultData = List<TopAlbumModel>.empty(growable: true);

    final weekData = localJson['weekData'];
    final monthData = localJson['monthData'];
    if (weekData != null) {
      final list =
          (weekData as List).map((e) => TopAlbumCoverInfo.fromJson(e)).toList();
      resultData.add(TopAlbumModel(label: '本周新碟', data: list));
    }
    if (monthData != null) {
      final list = (monthData as List)
          .map((e) => TopAlbumCoverInfo.fromJson(e))
          .toList();
      resultData
          .add(TopAlbumModel(dateTime: DateTime(year, month), data: list));
    }

    return resultData;
  }

  //播客所有 推荐的数据
  static Future<BlogHomeModel?> getBlogHomeData() async {
    // final response = await httpManager.get('/dj/category/recommend', null);
    // BlogHomeModel? data;
    // if (response.result) {
    //   data = BlogHomeModel.fromJson(response.data);
    // }
    // return data;

    await Future.delayed(const Duration(milliseconds: 200));
    final localJson =
        await CommonService.jsonDecode(JsonStringConstants.blog_recom_data);
    BlogHomeModel? data;
    data = BlogHomeModel.fromJson(localJson);
    return data;
  }

  // 获取播客 banner 数据
  static Future<List<BlogBannerModel>?> getBlogBannerData() async {
    // final response = await httpManager.get('/dj/banner', null);
    // var bannerList = List<BlogBannerModel>.empty(growable: true);
    // if (response.result) {
    //   final list = (response.data['data'] as List)
    //       .map((e) => BlogBannerModel.fromJson(e))
    //       .toList();
    //   bannerList = list;
    // }
    // return bannerList;

    await Future.delayed(const Duration(milliseconds: 200));
    var bannerList = List<BlogBannerModel>.empty(growable: true);
    final bannerJson =
        await CommonService.jsonDecode(JsonStringConstants.blog_banner_data);
    final list = (bannerJson['data'] as List)
        .map((e) => BlogBannerModel.fromJson(e))
        .toList();
    bannerList = list;
    return bannerList;
  }

  //获取播客 个性推荐-猜您喜欢
  //https://netease-cloud-music-api-masterxing.vercel.app/dj/personalize/recommend
  static Future<List<BlogPersonalModel>?> getBlogPersonData() async {
    // final response = await httpManager.get('/dj/personalize/recommend', null);
    // List<BlogPersonalModel>? data;
    // if (response.result) {
    //   final list = (response.data['data'] as List)
    //       .map((e) => BlogPersonalModel.fromJson(e))
    //       .toList();
    //   data = list;
    // }
    // return data;

    await Future.delayed(const Duration(milliseconds: 200));
    var personList = List<BlogPersonalModel>.empty(growable: true);
    final bannerJson =
        await CommonService.jsonDecode(JsonStringConstants.blog_personer_data);
    final list = (bannerJson['data'] as List)
        .map((e) => BlogPersonalModel.fromJson(e))
        .toList();
    personList = list;
    return personList;
  }

  //获取播客详情

  static Future<BlogDetailModel?> getBlogDetail(String rid) async {
    // final response = await httpManager.get('/dj/detail?rid=$rid', null);
    // BlogDetailModel? data;
    // if (response.result) {
    //   data = BlogDetailModel.fromJson(response.data['data']);
    // }
    // return data;

    await Future.delayed(const Duration(milliseconds: 200));
    BlogDetailModel? data;
    final json =
        await CommonService.jsonDecode(JsonStringConstants.blog_detail_data);
    data = BlogDetailModel.fromJson(json['data']);
    return data;
  }

  //获取播客详情下的列表
  static Future<BlogDetailListsModel?> getBlogDetailList(
      String rid, int limit) async {
    // final response =
    //     await httpManager.get('/dj/program?rid=$rid&limit=$limit', null);
    // BlogDetailListsModel? data;
    // if (response.result) {
    //   data = BlogDetailListsModel.fromJson(response.data);
    // }
    // return data;

    await Future.delayed(const Duration(milliseconds: 200));
    BlogDetailListsModel? data;
    final json =
        await CommonService.jsonDecode(JsonStringConstants.blog_detail_list);
    data = BlogDetailListsModel.fromJson(json);
    return data;
  }

  //获取视频Category
  static Future<List<VideoCategory>?> getVideoCategoryList() async {
    final metaData = DioMetaData(joinUri('/api/cloudvideo/group/list'),
        data: {}, options: joinOptions());
    final response = await httpManager.postUri(metaData);
    if (response.data["code"] == 200) {
      var categoryList = List<VideoCategory>.empty(growable: true);
      final list = (response.data['data'] as List)
          .map((e) => VideoCategory.fromJson(e))
          .toList();
      categoryList = list;
      return categoryList;
    } else {
      await Future.delayed(const Duration(milliseconds: 300));
      var categoryList = List<VideoCategory>.empty(growable: true);
      final categortJson =
          await CommonService.jsonDecode(JsonStringConstants.video_category);
      final list = (categortJson['data'] as List)
          .map((e) => VideoCategory.fromJson(e))
          .toList();
      categoryList = list;
      return categoryList;
    }
  }

  //获取视频分类下的视频 https://netease-cloud-music-api-masterxing.vercel.app/video/group
  //?id=$id&offset=$offset

  static Future<VideoGroupSourceList?> getVideoGroupListSource() async {
    await Future.delayed(const Duration(milliseconds: 200));
    VideoGroupSourceList? data;
    final json =
        await CommonService.jsonDecode(JsonStringConstants.video_group_list);
    data = VideoGroupSourceList.fromJson(json);
    return data;
  }

  //获取广场动态数据
  static Future<SquareInfo?> getSquareList() async {
    await Future.delayed(const Duration(milliseconds: 200));
    SquareInfo? info;
    final json =
        await CommonService.jsonDecode(JsonStringConstants.square_page_list);
    info = SquareInfo.fromJson(json['data']);
    return info;
  }

  //获取mine 歌单
  static Future<List<MineMusicList>?> getMineMusicList() async {
    await Future.delayed(const Duration(milliseconds: 200));
    var personList = List<MineMusicList>.empty(growable: true);
    final bannerJson =
        await CommonService.jsonDecode(JsonStringConstants.mine_music_list);
    final list = (bannerJson['data'] as List)
        .map((e) => MineMusicList.fromJson(e))
        .toList();
    personList = list;
    return personList;
  }

  //h获取videos
  static Future<List<VideoInfo>?> getVideoLists() async {
    await Future.delayed(const Duration(milliseconds: 200));
    var videoList = List<VideoInfo>.empty(growable: true);
    final json =
        await CommonService.jsonDecode(JsonStringConstants.video_lists);
    final list =
        (json['data'] as List).map((e) => VideoInfo.fromJson(e)).toList();
    videoList = list;
    return videoList;
  }

  //huoqu hishort
  static Future<List<HishortInfo>?> requestHiShortList() async {
    await Future.delayed(const Duration(milliseconds: 200));
    var videoList = List<HishortInfo>.empty(growable: true);
    final json =
        await CommonService.jsonDecode(JsonStringConstants.hishort_list);
    final list =
        (json['data'] as List).map((e) => HishortInfo.fromJson(e)).toList();
    videoList = list;
    return videoList;
  }

  ///获取用户数据
  static Future<List<AvatarInfo>?> getUsersLists() async {
    final json =
        await CommonService.jsonArrayDecode(JsonStringConstants.user_list);

    var userList = List<AvatarInfo>.empty(growable: true);
    final list = (json).map((e) {
      return AvatarInfo.fromJson(e);
    }).toList();
    userList = list;
    return userList;
  }

  //s
  static Future<List<HankanInfo>?> getHankVideoInfo() async {
    await Future.delayed(const Duration(milliseconds: 200));
    var videoList = List<HankanInfo>.empty(growable: true);
    final json =
        await CommonService.jsonDecode(JsonStringConstants.hank_videos);
    final list =
        (json['videos'] as List).map((e) => HankanInfo.fromJson(e)).toList();
    videoList = list;
    return videoList;
  }

  ///获取歌曲信息
  static Future<SongInfoListDto> getSongInfo(dynamic id) async {
    if (id is List) {
      id = id.join(',');
    }
    final res =
        await httpManager.get('/song/url/v1', {'id': id, 'level': 'exhigh'});
    return SongInfoListDto.fromJson(res.data);
  }
}
