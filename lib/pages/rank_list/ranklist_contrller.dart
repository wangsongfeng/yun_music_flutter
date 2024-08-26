import 'package:get/get.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';

class RanklistContrller extends GetxController {
  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }
}
