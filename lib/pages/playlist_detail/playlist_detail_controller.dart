import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:yun_music/api/music_api.dart';

import '../../commons/event/index.dart';
import '../../commons/event/play_bar_event.dart';

class PlaylistDetailController extends GetxController {
  String playlistId = ''; //歌单ID
  @override
  void onInit() {
    super.onInit();

    playlistId = Get.parameters['id'] ?? "";

    print(playlistId);
  }

  @override
  void onReady() {
    super.onReady();
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }

  Future<void> _getDetail({bool showLoading = false}) async {
    if (showLoading) EasyLoading.show();
    final detailModel = await MusicApi.getPlaylistDetail(playlistId);
  }
}
