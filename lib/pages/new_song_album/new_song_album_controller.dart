import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../utils/song_check_controller.dart';

class NewSongAlbumController extends CheckSongController {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: '新歌'),
    const Tab(text: '新碟'),
  ];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    final tabName = Get.parameters['tab']?.toString();
    tabController = TabController(
        initialIndex: tabName == null || tabName == 'song' ? 0 : 1,
        length: myTabs.length,
        vsync: this);
    tabController.addListener(() {
      showCheck.value = false;
      selectedSong.value = null;
    });
  }

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }
}
