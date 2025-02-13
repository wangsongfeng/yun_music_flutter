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
  RxBool loadings = false.obs;
  MediaItem? song;

  RxInt sortType = 2.obs;

  RxList<CommentItem> commentList = <CommentItem>[].obs;
  RxBool haseMore = false.obs;
  RxInt totalCount = 0.obs;

  int pageNo = 1;

  String cursor = "0";

  final commentWarp = Rx<CommentListData?>(null);

  final List<Tab> myTabs = <Tab>[
    const Tab(text: '评论'),
    const Tab(text: '瞬间'),
  ];

  late TabController tabController;
  late PageController pageController;

  final refreshController = RefreshController();
  late Future futureBuilderFuture;

  @override
  void onInit() {
    super.onInit();
    song = Get.arguments;
    tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);
    futureBuilderFuture = _requestCommentData(false);
  }

  Future _requestCommentData(bool clickType) async {
    if (clickType == true) {
      typeLoading.value = true;
      commentList.value = [];
    }
    loadings.value = true;
    String typeKey = _type2key("song") + song!.id;
    var value = await BujuanApi.getSongComment(song!.id, typeKey,
        sortType: sortType.value, pageNo: pageNo, cursor: cursor);
    if (value?.data != null) {
      haseMore.value = value?.data?.hasMore ?? false;
      totalCount.value = value?.data?.totalCount ?? 0;
      cursor = value?.data?.cursor ?? "0";
      if (pageNo == 1) {
        commentWarp.value = value?.data;
        commentList.value = commentWarp.value!.comments!;
      } else {
        commentList.addAll(value?.data!.comments as Iterable<CommentItem>);
      }
    } else {
      pageNo -= 1;
    }
    loadings.value = false;
    if (isLoading.value == true) {
      isLoading.value = false;
    }
    if (typeLoading.value == true) {
      typeLoading.value = false;
    }
    await Future.delayed(const Duration(milliseconds: 200));
    refreshController.loadComplete();
    if (haseMore.value == false) {
      refreshController.loadNoData();
    }
    return commentWarp.value;
  }

  //选择状态
  Future clickType(int type) async {
    if (sortType.value == type) return;
    sortType.value = type;
    cursor = "0";
    pageNo = 1;
    _requestCommentData(true);
  }

  //
  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (loadings.value == true) return;
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
    refreshController.dispose();
  }
}
