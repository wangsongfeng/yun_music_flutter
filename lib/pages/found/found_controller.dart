import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/tab_types.dart';

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

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);

    musicTabController = TabController(length: tabsConfig.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    pageController.dispose();
    musicTabController.dispose();
  }
}
