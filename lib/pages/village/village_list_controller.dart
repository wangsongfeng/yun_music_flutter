import 'package:get/get.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/pages/village/models/video_category.dart';
import 'package:yun_music/pages/village/models/video_group.dart';

class VillageListController extends SuperController<VideoGroupSourceList> {
  late VideoCategory tagModel;

  final videoData = Rx<VideoGroupSourceList?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    requestData();
  }

  Future<void> refreshData() async {
    requestData();
  }

  Future<void> loadMore() async {
    requestData();
  }

  void requestData() {
    MusicApi.getVideoGroupListSource().then((value) {
      if (value != null) {
        print(value);
        videoData.value = value;
        change(value, status: RxStatus.success());
      }
    });
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
