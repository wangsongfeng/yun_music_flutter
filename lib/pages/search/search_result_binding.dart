import 'package:get/get.dart';
import 'package:yun_music/pages/search/search_result_controller.dart';

class SearchResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchResultController>(() => SearchResultController());
  }
}
