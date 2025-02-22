import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/api/search_api.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/pages/search/models/search_hot_wrap.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';
import 'models/search_recommend.dart';

class WSearchController extends GetxController {
  int selectedIndex = 0;
  List<SearchTopModel> items = [];

  RxList<String> historyList = <String>[].obs;

  late final recommendHots = Rx<SearchRecommendResult?>(null);

  final FocusNode focusNode = FocusNode();

  TextEditingController textEditingController = TextEditingController();
  final hintText = "发现更多精彩".obs;

  SearchHotWrap? searchHotWrap;
  SearchHotTopicWrap? searchHotTopic;

  final hotRecommList = Rx<List>([]);

  final requestEnd = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initSearchTopList();
  }

//cm8_icon_play_list_artist
  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
    Future.delayed(const Duration(milliseconds: 300), () {
      focusNode.requestFocus();
    });

    requestData();
  }

  Future<void> requestData() async {
    recommendHots.value = await SearchApi.searchDefault();
    searchHotWrap = await SearchApi.requestSearchHotData();
    searchHotTopic = await SearchApi.requestSearchTopicData();

    hotRecommList.value = [
      {'type': "hot", "data": searchHotWrap?.data},
      {'type': 'topic', "data": searchHotTopic?.hot},
    ];
    requestEnd.value = true;
  }

  void _initSearchTopList() {
    List<String> textList = ["歌手", "曲风", "专区", "识曲"];
    List<String> imageList = [
      "cm2_lay_icn_artist_new",
      "cm2_lay_icn_type",
      "cm2_lay_icn_similar_new",
      "cm2_lay_icn_alb_new"
    ];

    items = textList
        .map((e) => SearchTopModel()
          ..text = e
          ..imageName = imageList[textList.indexOf(e)])
        .toList();
    final history = box.read<List<String>>(CACHE_SEARCH_HISTORY_DATA) ?? [];
    if (history.isNotEmpty) {
      historyList.value = history;
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }
}

class SearchTopModel {
  String? text;
  String? imageName;
}
