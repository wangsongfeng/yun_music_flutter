import 'package:get/get.dart';

import 'single_category_controller.dart';

class SingleCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleCategoryController>(() => SingleCategoryController());
  }
}
