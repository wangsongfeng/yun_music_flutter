import 'package:get/get.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/pages/dynamic_page/models/square_info.dart';

class SquareController extends SuperController<SquareInfo> {
  @override
  void onReady() {
    super.onReady();
    refreshData();
  }

  Future<void> refreshData() async {
    _requestData();
  }

  Future<void> loadMore() async {
    _requestData();
  }

  Future<void> _requestData() async {
    MusicApi.getSquareList().then((value) {
      change(value, status: RxStatus.success());
    }, onError: (e) {});
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
