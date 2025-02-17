import 'package:get/get.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';

class WSearchController extends GetxController {
  int selectedIndex = 0;
  @override
  void onInit() {
    super.onInit();
  }

//cm8_icon_play_list_artist
  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
