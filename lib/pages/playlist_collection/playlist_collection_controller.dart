import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/pages/playlist_collection/model/plsy_list_tag_model.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import '../../utils/common_utils.dart';

class PlaylistCollectionController extends GetxController
    with GetTickerProviderStateMixin {
  final String PLAYLIST_TAGS = "playlist_tags";
  int selectedIndex = 0;
  final tags = Rx<List<PlayListTagModel>?>(null);
  late TabController tabController;
  late PageController pageController;

  final localTags = [
    PlayListTagModel(true, true, '推荐', -1, 1, null),
    PlayListTagModel(true, true, '官方', -2, 1, null),
    PlayListTagModel(true, true, '精品', -3, 1, null),
  ];

  void setTabController() {
    tabController = TabController(
        length: tags.value!.length, vsync: this, initialIndex: selectedIndex);
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
    // if (box.hasData(PLAYLIST_TAGS)) {
    //   tags.value = box
    //       .read<List<dynamic>>(PLAYLIST_TAGS)!
    //       .map((e) => PlayListTagModel.fromJson(e))
    //       .toList();
    //   setTabController();
    // }
    if (GetUtils.isNullOrBlank(tags.value) == true) {
      getHotTags();
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.parameters.containsKey('tabPage')) {
      selectedIndex = int.parse(Get.parameters['tabPage'].toString());
    }
  }

  Future<void> getHotTags() async {
    final data = await MusicApi.getHotTags();
    if (data != null) {
      data.sort((a, b) => b.usedCount!.compareTo(a.usedCount!));
      final newTags = data.sublist(0, 5);
      newTags.insertAll(0, localTags);
      resetTags(newTags);
    } else {
      tags.value = localTags;
      setTabController();
    }
  }

  void resetTags(List<PlayListTagModel> data) {
    Get.log(data.map((e) => e.name).toString());
    box.write(PLAYLIST_TAGS, data.map((e) => e.toJson()).toList());
    tags.value = data;
    setTabController();
  }
}
