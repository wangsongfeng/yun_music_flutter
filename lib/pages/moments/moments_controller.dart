import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';

class MomentsController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
  }

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}
