import 'package:get/get.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';

class DrawerPageController extends GetxController {
  late bool viewAppear = false;
  @override
  void onReady() {
    super.onReady();
    print('onReady');

    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
  }
}
