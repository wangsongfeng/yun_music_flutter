import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:yun_music/commons/values/keys.dart';
import 'package:yun_music/vmusic/handle/music_handle.dart';

import '../commons/models/song_model.dart';
import '../utils/image_utils.dart';

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

  static PlayingController get to => Get.find<PlayingController>();

  @override
  void onInit() {
    super.onInit();
    String repeatMode = box.get(REPEAT_MODE, defaultValue: 'all');
    audioServiceRepeatMode.value = AudioServiceRepeatMode.values
            .firstWhereOrNull((element) => element.name == repeatMode) ??
        AudioServiceRepeatMode.all;

    getRepeatAsset();
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
      duration.value = Duration.zero;
      if (value == null) return;
      mediaItem.value = value;

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
