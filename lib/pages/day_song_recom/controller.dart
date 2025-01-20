import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/pages/day_song_recom/state.dart';
import 'package:yun_music/utils/song_check_controller.dart';
import 'package:yun_music/vmusic/playing_controller.dart';

class DaySongRecmController extends CheckSongController {
  final state = RecomSongDayState();

  List<Song> items() => state.recomModel.value?.dailySongs ?? List.empty();
  Rx<List<MediaItem>> mediaSongs = Rx<List<MediaItem>>(<MediaItem>[]);
  //列表中随机一直图当背景
  final randomPic = ''.obs;

  @override
  void onReady() {
    super.onReady();
    _requestData();
    showCheck.listen((p0) {});
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.bootom));
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _requestData() async {
    MusicApi.getRcmdSongs().then((value) {
      if (value != null) {
        for (final reason in value.recommendReasons) {
          final index = value.dailySongs
              .indexWhere((element) => element.id == reason.songId);
          if (index != -1) {
            value.dailySongs.elementAt(index).reason = reason.reason;
          }
        }
        final index = Random().nextInt(value.dailySongs.length);
        randomPic.value = value.dailySongs.elementAt(index).al.picUrl ?? '';
      }
      state.recomModel.value = value;
      mediaSongs.value =
          PlayingController.to.songToMediaItem(value!.dailySongs);
    });
  }

  void playList(BuildContext context, {Song? song}) {}
}
