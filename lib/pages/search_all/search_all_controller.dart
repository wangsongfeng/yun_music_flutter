import 'package:get/get.dart';
import 'package:yun_music/pages/search/models/search_result_wrap.dart';

import '../../api/search_api.dart';

class SearchAllController extends SuperController<SearchResultWrapX> {
  late String searchKey;
  late final recomData = Rx<SearchResultWrapX?>(null);

  Future<void> resultSearchKey(String keyWord) async {
    SearchApi.searchComplex(keyWord).then((value) {
      recomData.value = value;
      change(value, status: RxStatus.success());
    }, onError: (err) {
      print(err);
      if (recomData.value == null) {
        change(state, status: RxStatus.error());
      } else {
        change(recomData.value, status: RxStatus.success());
      }
    });
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
