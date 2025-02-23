import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';

class SearchResultController extends GetxController
    with GetTickerProviderStateMixin {
  late String searchKey = "";

  late List<String> tabList = ["综合", "单曲", "歌单", "歌手", "视频", "专辑", "歌词", "用户"];
  late TabController tabController;
  late PageController pageController;

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }

  void setTabController() {
    tabController =
        TabController(length: tabList.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);
  }
}
