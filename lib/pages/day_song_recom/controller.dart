import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/api/music_api.dart';
import 'package:yun_music/commons/event/index.dart';
import 'package:yun_music/commons/event/play_bar_event.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/player/player_context.dart';
import 'package:yun_music/pages/day_song_recom/state.dart';
import 'package:yun_music/utils/song_check_controller.dart';

class DaySongRecmController extends CheckSongController {
  final state = RecomSongDayState();

  List<Song> items() => state.recomModel.value?.dailySongs ?? List.empty();
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
    });
  }

  void playList(BuildContext context, {Song? song}) {
    context.playerService.playList(items(), song!);
  }
}
