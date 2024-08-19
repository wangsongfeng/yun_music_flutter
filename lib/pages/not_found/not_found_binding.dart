import 'package:get/get.dart';
import 'package:yun_music/pages/not_found/not_found_controller.dart';

class NotFoundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotFoundController>(() => NotFoundController());
  }
}
