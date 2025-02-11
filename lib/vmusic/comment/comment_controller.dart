import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/api/bujuan_api.dart';
import 'package:yun_music/commons/values/server.dart';

import '../model/comment_list.dart';

class MCommentController extends GetxController
    with GetTickerProviderStateMixin {
  RxBool isLoading = true.obs;
  MediaItem? song;

  final commentWarp = Rx<CommentListData?>(null);

  final List<Tab> myTabs = <Tab>[
    const Tab(text: '评论'),
    const Tab(text: '瞬间'),
  ];

  late TabController tabController;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    song = Get.arguments;
    logger.d("songId-${song?.id}");
    tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);

    _requestCommentData();
  }

  Future _requestCommentData() async {
    String typeKey = _type2key("song") + song!.id;
    await BujuanApi.getSongComment(song!.id, typeKey, sortType: 1)
        .then((value) {
      print(value);
      commentWarp.value = value;
    });
    isLoading.value = false;
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
