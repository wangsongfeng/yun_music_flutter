import 'package:get/get.dart';
import 'package:yun_music/api/bujuan_api.dart';
import 'package:yun_music/pages/dynamic_page/models/bu_new_song.dart';
import 'package:yun_music/pages/dynamic_page/models/bu_song_list_info.dart';

class AttentionController extends GetxController {
  RxBool isLoading = true.obs;
  final playListWarp = Rx<BuSongPlayListWarp?>(null);
  final newSongListWarp = Rx<BuNewSongListWarp?>(null);
  @override
  void onReady() {
    super.onReady();
    _personalizedPlaylist();
  }

  void loadRefresh() {
    _personalizedPlaylist();
  }

  //推荐歌单
  Future _personalizedPlaylist() async {
    await BujuanApi.requestPersonPlayList().then((value) {
      playListWarp.value = value;
      print(value.result?.length);
    });

    await BujuanApi.personalizedSongList().then((value) {
      newSongListWarp.value = value;
    });

    isLoading.value = false;
  }
}
