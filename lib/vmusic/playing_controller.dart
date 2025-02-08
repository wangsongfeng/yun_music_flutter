import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:yun_music/api/bujuan_api.dart';
import 'package:yun_music/commons/values/keys.dart';
import 'package:yun_music/commons/values/server.dart';
import 'package:yun_music/vmusic/handle/music_handle.dart';
import 'package:yun_music/vmusic/model/lyric_info_model.dart';

import '../commons/models/song_model.dart';
import '../utils/image_utils.dart';
import 'model/lyrics_reader_model.dart';
import 'model/parser_lrc.dart';

class PlayingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final box = GetIt.instance<Box>();

  RxBool loading = false.obs;
  //歌词 播放列表pageview下标
  RxInt selectIndex = 0.obs;

  //audio handle
  final audioHandler = GetIt.instance<MusicHandle>();

  //当前播放歌曲
  Rx<MediaItem> mediaItem =
      const MediaItem(id: '', title: '暂无', duration: Duration(seconds: 10)).obs;
  //当前播放列表
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;

  Rx<List<MediaItem>?> playLists = Rx<List<MediaItem>>(<MediaItem>[]);

  RxInt currentIndex = 0.obs;

  //是否正在播放中
  RxBool playing = false.obs;

  //是否是Fm
  RxBool fm = false.obs;

  //播放进度
  Rx<Duration> duration = Duration.zero.obs;
  Duration lastDuration = Duration.zero;

  //循环模式
  Rx<AudioServiceRepeatMode> audioServiceRepeatMode =
      AudioServiceRepeatMode.all.obs;
  //循环模式的icon asset
  Rx<String> repeartAsset = "".obs;
  Rx<String> repeartTitle = "".obs;

  var lastPopTime = DateTime.now();

  //是否开启高音质
  RxBool high = false.obs;

  final showNeedle = false.obs;

  //解析后的歌词数组
  List<LyricsLineModel> lyricsLineModels = <LyricsLineModel>[].obs;
  //是否有翻译歌词
  RxBool hasTran = false.obs;

  static PlayingController get to => Get.find<PlayingController>();

  //是否正在展示歌词
  RxBool showLyric = false.obs;
  //歌词是否被用户滚动中
  RxBool onMove = false.obs;
  //当前歌词下标
  int lastIndex = 0;
  RxInt moveLyricIndex = 0.obs;
  RxInt currLyricIndex = 0.obs;
  RxString currLyric = ''.obs;

  RxDouble scrollDown = 0.0.obs;
  RxBool canScroll = true.obs;
  //是否开启顶部歌词
  RxBool topLyric = true.obs;

  //歌词滚动控制器
  FixedExtentScrollController lyricScrollController =
      FixedExtentScrollController();

  @override
  void onInit() {
    super.onInit();
    String repeatMode = box.get(REPEAT_MODE, defaultValue: 'all');
    audioServiceRepeatMode.value = AudioServiceRepeatMode.values
            .firstWhereOrNull((element) => element.name == repeatMode) ??
        AudioServiceRepeatMode.all;

    getRepeatAsset();

    topLyric.value = box.get(topLyricSp, defaultValue: false);
  }

  @override
  void onReady() {
    super.onReady();
    _initListenValue();
  }

  @override
  void onClose() {
    super.onClose();
  }

  _initListenValue() {
    //监听 整体播放数据变化
    audioHandler.queue.listen((value) {
      mediaItems
        ..clear()
        ..addAll(value);
      playLists.value
        ?..clear()
        ..addAll(value);
    });

    audioHandler.mediaItem.listen((value) async {
      lyricsLineModels.clear();
      currLyric.value = '';
      moveLyricIndex.value = -1;
      currLyricIndex.value = -1;
      duration.value = Duration.zero;
      if (value == null) return;
      mediaItem.value = value;
      _getLyricInfo();
      currentIndex.value =
          mediaItems.indexWhere((e) => e.id == mediaItem.value.id);
      //获取歌词
    });

    AudioService.createPositionStream(
            minPeriod: const Duration(microseconds: 800), steps: 1000)
        .listen((event) {
      if (event.inMicroseconds >
          (mediaItem.value.duration?.inMicroseconds ?? 0)) {
        {
          duration.value = Duration.zero;
          return;
        }
      }
      duration.value = event;
      if (!onMove.value && lyricsLineModels.isNotEmpty) {
        int index = lyricsLineModels.indexOf(lyricsLineModels.firstWhere(
            (element) => element.startTime! >= duration.value.inMilliseconds));
        if (index != -1 && index != lastIndex) {
          logger.d("移动中");
          lyricScrollController.animateToItem((index > 0 ? index - 1 : index),
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
          lastIndex = index;
          currLyricIndex.value = (index > 0 ? index - 1 : index);
          if (topLyric.value) {
            currLyric.value =
                lyricsLineModels[(index > 0 ? index - 1 : index)].mainText ??
                    '';
          }
        }
      }
    });

    audioHandler.playbackState.listen((value) {
      playing.value = value.playing;
    });
  }

  void playOrPause() async {
    if (playing.value) {
      await audioHandler.pause();
    } else {
      await audioHandler.play();
    }
  }

  playByIndex(int index, String queueTitle,
      {List<MediaItem>? mediaItem}) async {
    audioHandler.queueTitle.value = queueTitle;
    audioHandler.changeQueueLists(mediaItem ?? [], index: index);
  }

  /**
   * 获取歌词
   */
  Future<void> _getLyricInfo() async {
    hasTran.value = false;
    String lyric = box.get('lyric_${mediaItem.value.id}') ?? '';
    String lyricTran = box.get('lyricTran_${mediaItem.value.id}') ?? '';
    if (lyric.isEmpty) {
      SongLyricWrap songLyricWrap =
          await BujuanApi.songLyric(mediaItem.value.id);
      lyric = songLyricWrap.lrc.lyric ?? "";
      lyricTran = songLyricWrap.tlyric.lyric ?? "";
      box.put('lyric_${mediaItem.value.id}', lyric);
      box.put('lyricTran_${mediaItem.value.id}', lyricTran);
    }
    if (lyric.isNotEmpty) {
      var list = ParserLrc(lyric).parseLines();
      var listTran = ParserLrc(lyricTran).parseLines();
      if (lyricTran.isNotEmpty) {
        hasTran.value = true;
        lyricsLineModels.addAll(list.map((e) {
          int index = listTran
              .indexWhere((element) => element.startTime == e.startTime);
          if (index != -1) e.extText = listTran[index].mainText;
          return e;
        }).toList());
      } else {
        lyricsLineModels.addAll(list);
      }
    }
  }

  Future<void> changeRepeatMode() async {
    switch (audioServiceRepeatMode.value) {
      case AudioServiceRepeatMode.one:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.none;
        break;
      case AudioServiceRepeatMode.none:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.all;
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.one;
        break;
    }
    audioHandler.setRepeatMode(audioServiceRepeatMode.value);
    box.put(REPEAT_MODE, audioServiceRepeatMode.value.name);
    getRepeatAsset();
  }

  void getRepeatAsset() {
    switch (audioServiceRepeatMode.value) {
      case AudioServiceRepeatMode.one:
        repeartAsset.value = ImageUtils.getImagePath('cm6_icn_one');
        repeartTitle.value = "单曲循环";
        break;
      case AudioServiceRepeatMode.none:
        repeartAsset.value = ImageUtils.getImagePath('cm6_icn_shuffle');
        repeartTitle.value = "随机播放";
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        repeartAsset.value = ImageUtils.getImagePath('cm6_icn_loop');
        repeartTitle.value = "列表循环";
        break;
    }
  }

  List<MediaItem> songToMediaItem(List<Song> songs, {String? typeName}) {
    return songs
        .map((e) => MediaItem(
                id: e.id.toString(),
                title: e.name,
                album: e.al.name,
                duration: Duration(milliseconds: e.dt ?? 0),
                artUri: Uri.parse('${e.al.picUrl}'),
                artist: (e.ar).map((e) => e.name).toList().join(' / '),
                extras: {
                  'type': MediaType.playlist.name,
                  'image': e.al.picUrl,
                  'mv': e.mv,
                  'fee': e.fee,
                  'title': typeName
                }))
        .toList();
  }

  Future<MediaItem> getPreviousMediaItem() async {
    var prevIndex = currentIndex.value - 1;
    if (prevIndex < 0) {
      prevIndex = mediaItems.length - 1;
    }

    return audioHandler.queue.value[prevIndex];
  }

  Future<MediaItem> getNextMusic() async {
    var nextIndex = currentIndex.value + 1;
    if (nextIndex >= mediaItems.length) {
      nextIndex = 0;
    }
    return audioHandler.queue.value[nextIndex];
  }

  // 防治重复点击
  bool intervalClick() {
    if (DateTime.now().difference(lastPopTime) >
        const Duration(microseconds: 800)) {
      lastPopTime = DateTime.now();
      return true;
    } else {
      return false;
    }
  }
}
