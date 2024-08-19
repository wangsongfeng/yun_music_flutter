import 'package:get/get.dart';
import 'package:yun_music/pages/found/found_controller.dart';

class FoundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoundController>(() => FoundController());
  }
}
