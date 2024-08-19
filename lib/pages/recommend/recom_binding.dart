
import 'package:get/get.dart';
import 'package:yun_music/pages/recommend/recom_controller.dart';

class RecomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecomController>(() => RecomController());
  }
  
}