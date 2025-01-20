import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: '关注'),
    const Tab(text: '广场'),
  ];

  late TabController tabController;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 1);
    pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    pageController.dispose();
  }
}
