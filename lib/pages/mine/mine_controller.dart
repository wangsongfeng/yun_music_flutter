// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/utils/adapt.dart';

class MineController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late PageController pageController;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: '音乐'),
    const Tab(text: '播客'),
    const Tab(text: '动态'),
  ];

  final headerHeight = 296.0.obs;

  final appbarHeight = (50 + Adapt.topPadding());

  final menuBarTop = 0.0.obs;
  late double menuBarTop_Normal = 0;
  final appbar_alpha = 0.0.obs;

  //是否是垂直滑动
  bool isVerticalMove = false;
  //初始坐标
  double initialDy = 0;
  double initialDx = 0;

  final extraPicHeight = 0.0.obs;
  final prev_dy = 0.0.obs;
  final Rx<BoxFit> fitType = BoxFit.cover.obs;

  @override
  void onInit() {
    super.onInit();
    menuBarTop.value = headerHeight.value;
    menuBarTop_Normal = menuBarTop.value;
    tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    pageController.dispose();
  }
}
