import 'package:get/get.dart';
import 'package:yun_music/video/logic.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VideoLogic());
  }
}
