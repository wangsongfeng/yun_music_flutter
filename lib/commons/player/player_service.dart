import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/player/bottom_player_controller.dart';
import 'package:yun_music/utils/common_utils.dart';
import '../values/constants.dart';

class PlayerService extends GetxService {
  static PlayerService get to => Get.find();

  late AudioPlayer player;

  //是否是私人FM
  final isFmPlaying = false.obs;

  //当前播放的歌曲ID
  final curPlayId = Rx<int?>(null);

  //当前播放的歌曲
  final curPlay = Rx<Song?>(null);

  //播放列表ID
  final queueIdValue = ''.obs;

  //播放列表大小
  final queueSizeValue = 0.obs;

  //刚进入下一页面PlayBar的变化
  final plarBarBottom = 0.0.obs;

  final playBarHeight = 0.0.obs;

  //以选中的歌曲
  final selectedSongList = Rx<List<Song>?>(null);
  final selectedSong = Rx<Song?>(null);

  final playingBgColor = Rx<Color?>(null);

  @override
  void onInit() {
    super.onInit();
    player = AudioPlayer();
    getCachePlayingList();
    _update();
  }

  void _update() {
    curPlayId.value = selectedSong.value?.id;
    curPlay.value = selectedSong.value;
  }

  void getCachePlayingList() {
    final playingList = box.read(kCommonPlayingList);

    final currentSong = box.read<Map<String, dynamic>>(kCurrentPlayingSong);
    if (playingList != null) {
      final List<dynamic> jsonArray = jsonDecode(playingList);
      selectedSongList.value = jsonArray.map((e) => Song.fromJson(e)).toList();
    }
    if (currentSong != null) {
      selectedSong.value = Song.fromJson(currentSong);
    }
  }

  void playList(List<Song> list, Song song) {
    if (listEquals(selectedSongList.value, list) == false) {
      box.write(kCommonPlayingList, jsonEncode(list));
      box.write(kCurrentPlayingSong, song.toJson());
      selectedSongList.value = list;
    }
    selectedSong.value = song;
    _update();
    final playerController = Get.find<PlayerController>();
    final currenIndex = selectedSongList.value
        ?.indexWhere((element) => element.id == curPlayId.value);
    if (currenIndex != -1) {
      playerController.pageController?.animateToPage(currenIndex!,
          duration: const Duration(milliseconds: 10), curve: Curves.easeIn);
    }
  }

  void playFromIndex(int index) {
    final currentSong = selectedSongList.value?[index];
    selectedSong.value = currentSong;
    _update();
  }

  void getPlayingBgColor() {
    PaletteGenerator.fromImageProvider(
            NetworkImage(PlayerService.to.curPlay.value?.al.picUrl ?? ""))
        .then((paletteGenerator) {
      if (paletteGenerator.darkVibrantColor != null) {
        playingBgColor.value = paletteGenerator.darkMutedColor?.color;
      } else {
        playingBgColor.value = paletteGenerator.colors.first;
      }
    });
  }
}
