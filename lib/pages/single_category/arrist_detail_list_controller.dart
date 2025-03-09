import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:yun_music/api/artist_api.dart';
import 'package:yun_music/vmusic/playing_controller.dart';

import '../../commons/models/song_model.dart';

class ArristDetailListController extends GetxController {
  //全部歌曲集合
  final songs = Rx<List<Song>?>(null);
  Rx<List<MediaItem>> mediaSongs = Rx<List<MediaItem>>(<MediaItem>[]);
  //是否展示编辑
  final showCheck = false.obs;
  //已选中的歌曲
  final selectedSong = Rx<List<Song>?>(null);

  final songTypes = ["演唱", "作词", "作曲", "编曲", "制作"];
  final selectedSongType = 0.obs;

  Future requestArtistAllSongList(String artistId) async {
    final resultList = await ArtistApi.artistALLSongList(artistId);
    songs.value = resultList;

    mediaSongs.value = PlayingController.to.songToMediaItem(songs.value!);
  }
}
