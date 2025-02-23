import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/api/bujuan_api.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/pages/village/models/video_category.dart';

class VillageController extends GetxController
    with GetTickerProviderStateMixin {
  final tags = Rx<List<VideoCategory>?>(null);

  late TabController tabController;
  late PageController pageController;

  @override
  void onReady() {
    super.onReady();

    getTags();
  }

  void setTabController() {
    tabController =
        TabController(length: tags.value!.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: 0);
  }

  void getTags() {
    MusicApi.getVideoCategoryList().then((value) {
      tags.value = value;
      setTabController();
    });

    BujuanApi.artistList(-1);
  }
}
