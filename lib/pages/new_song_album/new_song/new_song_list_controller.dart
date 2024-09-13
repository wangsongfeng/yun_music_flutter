import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/player/player_context.dart';

import '../../../api/music_api.dart';
import '../../../commons/models/song_model.dart';

class NewSongListController extends GetxController {
  final int typeId;

  NewSongListController({required this.typeId});

  final items = Rx<List<Song>?>(null);

  @override
  void onReady() {
    super.onReady();
    requestSongs();
  }

  Future<void> requestSongs() async {
    //推荐歌单
    if (typeId == -1) {
      MusicApi.getRecmNewSongs().then((value) => items.value = value);
    } else {
      //新歌速递
      MusicApi.getNewSongFromTag(typeId).then((value) => items.value = value);
    }
  }

  void playList(BuildContext context, {Song? song}) {
    context.playerService.playList(items.value!, song!);
  }
}
