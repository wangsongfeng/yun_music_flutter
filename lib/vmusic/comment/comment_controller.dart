import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/api/bujuan_api.dart';

import '../model/comment_list.dart';

class MCommentController extends GetxController
    with GetTickerProviderStateMixin {
  RxBool isLoading = true.obs;
  RxBool typeLoading = false.obs;
  RxBool loadMore = false.obs;
  MediaItem? song;

  RxInt sortType = 1.obs;

  int pageNo = 1;

  final commentWarp = Rx<CommentListData?>(null);

  late final CommentListData? currentListData;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: '评论'),
    const Tab(text: '瞬间'),
  ];

  late TabController tabController;
  late PageController pageController;

  late RefreshController refreshController;
  late Future futureBuilderFuture;

  @override
  void onInit() {
    super.onInit();
    song = Get.arguments;
    tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);
    refreshController = RefreshController();

    futureBuilderFuture = _requestCommentData(false);
  }

  Future _requestCommentData(bool clickType) async {
    if (clickType == true) {
      typeLoading.value = true;
    }
    loadMore.value = false;
    String typeKey = _type2key("song") + song!.id;
    await BujuanApi.getSongComment(song!.id, typeKey,
            sortType: sortType.value, pageNo: pageNo)
        .then((value) {
      if (value != null) {
        if (pageNo == 1) {
          commentWarp.value = value;
        } else {
          loadMore.value = true;
          commentWarp.value?.comments
              ?.addAll(value.comments as Iterable<CommentItem>);
        }
      }
    });
    isLoading.value = false;
    typeLoading.value = false;
    refreshController.refreshCompleted();
    if (commentWarp.value?.hasMore == true) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
    return commentWarp.value;
  }

  //选择状态
  Future clickType(int type) async {
    if (sortType.value == type) return;
    sortType.value = type;
    pageNo = 1;
    loadMore.value = false;
    _requestCommentData(true);
  }

  //
  Future<void> onLoading() async {
    pageNo += 1;
    _requestCommentData(false);
  }

  String _type2key(String type) {
    String typeKey = 'R_SO_4_';
    switch (type) {
      case 'song':
        typeKey = 'R_SO_4_';
        break;
      case 'mv':
        typeKey = 'R_MV_5_';
        break;
      case 'playlist':
        typeKey = 'A_PL_0_';
        break;
      case 'album':
        typeKey = 'R_AL_3_';
        break;
      case 'dj':
        typeKey = 'A_DJ_1_';
        break;
      case 'video':
        typeKey = 'R_VI_62_';
        break;
      case 'event':
        typeKey = 'A_EV_2_';
        break;
    }
    return typeKey;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    pageController.dispose();
  }
}
