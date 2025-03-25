import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/res/tab_types.dart';
import 'package:yun_music/utils/extensions.dart';

import '../../api/bujuan_api.dart';
import '../../commons/values/constants.dart';
import '../../utils/common_utils.dart';
import '../dynamic_page/models/bu_song_list_info.dart';
import '../recommend/models/recom_model.dart';

class FoundController extends GetxController with GetTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: '音乐'),
    const Tab(text: '播客'),
    const Tab(text: '听书'),
  ];

  final tabsConfig = foundTabsConfig;

  late TabController tabController;
  late PageController pageController;
  late TabController musicTabController;
  late PageController musicPageController;

  late List<String> carousels = [
    "http://p1.music.126.net/S3gagnspa33-UiRC8z2MMA==/109951170644942059.jpg?imageView&quality=89",
    "http://p1.music.126.net/t5dYADRo5An8T6v7K3eVAw==/109951170638568923.jpg?imageView&quality=89",
    "http://p1.music.126.net/-ryslZ0oWDfci-tdjtDbOw==/109951170638577773.jpg?imageView&quality=89",
    "http://p1.music.126.net/Mw7wUGY69G0r1b7RIVixjA==/109951170644963457.jpg?imageView&quality=89",
    "http://p1.music.126.net/cbO47P2BBIfDcU9H6NZCTg==/109951170640572544.jpg?imageView&quality=89",
    "http://p1.music.126.net/v9Nd9rE1hxF-JjelHxq1lg==/109951170638594130.jpg?imageView&quality=89",
    "http://p1.music.126.net/_x_I-MdwcvIv8x_capC9rg==/109951170644945607.jpg?imageView&quality=89",
  ];

  late RefreshController refreshController = RefreshController();

  RxBool isLoading = true.obs;
  final playListWarp = Rx<BuSongPlayListWarp?>(null);

  List<BuSongListInfo> songListOne = [];
  List<BuSongListInfo> songListTwo = [];
  late Blocks? newSongs;

  final RxList<dynamic> blocks = [].obs;

  @override
  void onInit() {
    super.onInit();

    tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);

    musicTabController =
        TabController(length: tabsConfig.length, vsync: this, initialIndex: 0);

    musicPageController = PageController(initialPage: 0);

    requestRecommendData();
  }

  //推荐歌单
  Future requestRecommendData() async {
    blocks.clear();
    playListWarp.value = await BujuanApi.requestPersonPlayList();
    playListWarp.value!.result?.sublist(1);
    final List<List<BuSongListInfo>>? chundList =
        playListWarp.value?.result!.chunked(5);
    if (chundList!.length >= 2) {
      songListOne = chundList.first;
      songListTwo = chundList.last;
    }
    blocks.add({"type": "banner", "list": carousels});
    blocks.add({"type": "playlist", "list": songListOne, "title": "甄选歌单"});
    blocks.add({"type": "playlist", "list": songListTwo, "title": "云村新鲜事"});

    final cacheData =
        box.read<Map<String, dynamic>?>(CACHE_HOME_RECOMMEND_DATA);
    if (cacheData != null) {
      List<Blocks> recomblocks = cacheData["blocks"];
      List<Blocks> list = recomblocks
          .where(
              (item) => item.showType == SHOWTYPE_HOMEPAGE_SLIDE_SONGLIST_ALIGN)
          .toList();
      if (list.isNotEmpty) {
        newSongs = list.first;
        blocks.add({"type": "newSong", "list": newSongs, "title": "新歌新碟"});
      }
    }
    isLoading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    pageController.dispose();
    musicTabController.dispose();
    musicPageController.dispose();
  }
}
