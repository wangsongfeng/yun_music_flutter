import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/music_api.dart';
import '../../../commons/models/mine_music_list.dart';

class MineMusicController extends GetxController
    with GetTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: '近期'),
    const Tab(text: '创建'),
    const Tab(text: '收藏'),
  ];

  late TabController tabController;
  late PageController pageController;

  final mineMusicList = Rx<List<MineMusicList>?>(null);

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);
  }

  @override
  void onReady() {
    super.onReady();
    requestData();
  }

  Future requestData() async {
    final data = await MusicApi.getMineMusicList();
    mineMusicList.value = data;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    pageController.dispose();
  }
}
