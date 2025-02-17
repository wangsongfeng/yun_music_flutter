import 'package:get/get.dart';
import 'package:yun_music/pages/search/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WSearchController>(() => WSearchController());
  }
}
