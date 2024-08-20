import 'package:get/get.dart';
import 'package:yun_music/pages/playlist_collection/model/plsy_list_tag_model.dart';

import '../../../api/music_api.dart';
import '../model/playlist_has_more_model.dart';

class PlaylistContentController extends SuperController<PlaylistHasMoreModel> {
  late PlayListTagModel tagModel;
  final limit = 30;
  int offet = 0;

  bool requesting = false;

  //选中的精品type null：全部精品
  final cat = Rx<String?>(null);
  //精品歌单筛选列表
  List<String>? highqualityTags;

  @override
  void onReady() {
    super.onReady();
    print("ready--${tagModel.name}");
    refreshData();
  }

  Future<void> refreshData() async {
    offet = 0;
    _requestData();
  }

  Future<void> loadMore() async {
    offet = state!.datas.length;
    _requestData();
  }

  Future<void> _requestData() async {
    switch (tagModel.name) {
      case '推荐':
        getRcmPlayList();
        break;
      case '精品':
        if (highqualityTags == null) {
          getHighqualityTags();
        }
        getHighqualityList();
        break;
      default:
        getPlayListFromTag();
        break;
    }
  }

  //分类歌单列表
  Future<void> getPlayListFromTag() async {
    MusicApi.getPlayListFromTag(tagModel.name, limit, offet).then((newValue) {
      if (offet == 0) {
        change(newValue, status: RxStatus.success());
      } else {
        //加载更多
        final newList = state!.datas.toList();
        newList.addAll(newValue!.datas);
        change(
            PlaylistHasMoreModel(
                datas: newList, totalCount: newValue.totalCount),
            status: RxStatus.success());
      }
    }, onError: (err) {});
  }

  //推荐歌单列表
  Future<void> getRcmPlayList() async {
    MusicApi.getRcmPlayList().then((value) {
      change(value, status: RxStatus.success());
    }, onError: (error) {});
  }

  //获取精品歌单筛选项
  Future<void> getHighqualityTags() async {
    highqualityTags = await MusicApi.getHighqualityTags();
  }

  //精品歌单列表
  Future<void> getHighqualityList() async {
    requesting = true;
    MusicApi.getHighqualityList(
            cat.value, limit, offet == 0 ? null : state?.datas.last.updateTime)
        .then((newValue) {
      requesting = false;
      if (offet == 0) {
        change(newValue, status: RxStatus.success());
      } else {
        //加载更多
        final newList = state!.datas.toList();
        newList.addAll(newValue!.datas);
        change(
            PlaylistHasMoreModel(
                datas: newList, totalCount: newValue.totalCount),
            status: RxStatus.success());
      }
    }, onError: (err) {
      requesting = false;
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
