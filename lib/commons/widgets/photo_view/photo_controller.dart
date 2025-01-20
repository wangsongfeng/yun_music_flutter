import 'package:get/get.dart';
import 'package:yun_music/commons/event/index.dart';

import '../../event/play_bar_event.dart';

class PhotoController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
  }
}
