import 'package:get/get.dart';
import 'package:yun_music/api/bujuan_api.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/pages/village/models/video_category.dart';
import 'package:yun_music/pages/village/models/video_group.dart';

class VillageListController extends SuperController<VideoGroupSourceList> {
  late VideoCategory tagModel;

  final videoData = Rx<VideoGroupSourceList?>(null);

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
        videoData.value = value;
        change(value, status: RxStatus.success());
      }
    });

    BujuanApi.videoListByGroup("0");
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
