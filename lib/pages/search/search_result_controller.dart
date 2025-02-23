import 'package:get/get.dart';

class SearchResultController extends GetxController {
  late String searchKey = "";

  @override
  void onInit() {
    super.onInit();
    searchKey = Get.arguments["searchKey"];
    print(searchKey);
  }
}
