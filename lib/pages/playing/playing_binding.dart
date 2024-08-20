import 'package:get/get.dart';
import 'package:yun_music/pages/playing/playing_controller.dart';

class PlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayingController>(() => PlayingController());
  }
}
