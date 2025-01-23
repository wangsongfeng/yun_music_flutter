import 'dart:convert';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:yun_music/api/bujuan_api.dart';
import 'package:yun_music/commons/values/keys.dart';
import 'package:yun_music/commons/values/server.dart';
import 'package:yun_music/vmusic/playing_controller.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/vmusic/handle/audio_player_handle.dart';

import '../../commons/values/platform_utils.dart';

Future<List<MediaItem>> getCachePlayList(RootIsolateData data) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(data.rootIsolateToken);
  List<MediaItem> items = data.playList?.map((e) {
        var map = MediaItemMessage.fromMap(jsonDecode(e));
        return MediaItem(
          id: map.id,
          title: map.title,
          duration: map.duration,
          artUri: map.artUri,
          extras: map.extras,
          artist: map.artist,
          album: map.album,
        );
      }).toList() ??
      [];

  return items;
}

Future<List<String>> setCachePlayList(RootIsolateData data) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(data.rootIsolateToken);
  return data.items
          ?.map((e) => jsonEncode(MediaItemMessage(
                id: e.id,
                album: e.album,
                title: e.title,
                artist: e.artist,
                duration: e.duration,
                artUri: e.artUri,
                extras: e.extras,
              ).toMap()))
          .toList() ??
      [];
}

class RootIsolateData {
  RootIsolateToken rootIsolateToken;
  List<String>? playList;
  List<MediaItem>? items;

  RootIsolateData(this.rootIsolateToken, {this.playList, this.items});
}

class MusicHandle extends BaseAudioHandler
    with SeekHandler, QueueHandler
    implements AudioPlayerHandle {
  final AudioPlayer _audioPlayer = GetIt.instance<AudioPlayer>();
  final Box _box = GetIt.instance<Box>();
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

  final _playList = <MediaItem>[];
  final _playListShut = <MediaItem>[];

  //循环模式
  AudioServiceRepeatMode _audioServiceRepeatMode = AudioServiceRepeatMode.all;
  int _currentIndex = 0;
  // 预加载的下一首歌曲URL
  String? _nextSongUrl;
  // 预加载的上一首歌曲URL
  String? _previousSongUrl;

  //播放失败次数
  int faileCount = 0;

  MusicHandle() {
    _loadPlayListByStorage(); //启动后加载本地数据
    _listenToPlaybackState(); //监听音乐事件
    _listenToPositionEvents(); //音乐position监听
    _listenToSequenceState(); //播放状态监听
  }

  //启动后加载本地数据
  Future<void> _loadPlayListByStorage() async {
    String repeatMode = _box.get(REPEAT_MODE, defaultValue: "all");
    _audioServiceRepeatMode = AudioServiceRepeatMode.values
            .firstWhereOrNull((element) => element.name == repeatMode) ??
        AudioServiceRepeatMode.all;
    _currentIndex = _box.get(PLAY_INDEX, defaultValue: 0);
    List<dynamic> dynamicList = _box.get(PLAY_QUEUE, defaultValue: []);
    List<String> playList = dynamicList.map((e) => e as String).toList();
    if (playList.isNotEmpty) {
      List<MediaItem> items = await compute(getCachePlayList,
          RootIsolateData(rootIsolateToken, playList: playList));
      await changeQueueLists(items, init: true, index: _currentIndex);
    }
  }

  void _listenToPositionEvents() {
    _audioPlayer.positionStream.listen((position) {
      playbackState.add(playbackState.value.copyWith(
        updatePosition: position,
      ));

      // 当播放进度超过80%时预加载下一首
      if (position.inMilliseconds >
          (_audioPlayer.duration?.inMilliseconds ?? 0) * 0.8) {
        _preloadNextSong();
      }
    });
  }

  void _listenToSequenceState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        skipToNext();
      } else if (playerState.processingState == ProcessingState.ready) {}
    });
  }

  void _listenToPlaybackState() {
    _audioPlayer.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _audioPlayer.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          PlatformUtils.isAndroid
              ? ((mediaItem.value?.extras?['liked'] ?? false)
                  ? const MediaControl(
                      label: 'fastForward',
                      action: MediaAction.fastForward,
                      androidIcon: 'drawable/audio_service_like')
                  : const MediaControl(
                      label: 'rewind',
                      action: MediaAction.rewind,
                      androidIcon: 'drawable/audio_service_unlike'))
              : const MediaControl(
                  label: 'setRating',
                  action: MediaAction.setRating,
                  androidIcon: 'drawable/audio_service_like'),
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
          MediaControl.stop,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [1, 2, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_audioPlayer.processingState]!,
        repeatMode: _audioServiceRepeatMode,
        shuffleMode: (_audioPlayer.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: _audioPlayer.position,
        bufferedPosition: _audioPlayer.bufferedPosition,
        speed: _audioPlayer.speed,
        queueIndex: _currentIndex,
      ));
    });
  }

  Future<void> setUrl(String url) async {
    await _audioPlayer.setUrl(url);
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {}
  @override
  Future<void> removeQueueItemAt(int index) async {
    if (index == _currentIndex) {
      toast("当前歌曲正在播放，无法删除");
      return;
    }
    _playList.removeAt(index);
    if (index < _currentIndex) {
      _currentIndex--;
    }
    final newQueue = queue.value..removeAt(index);
    queue.add(newQueue);
  }

  @override
  Future<void> fastForward() async {}

  @override
  Future<void> play() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> addFmItems(
      List<MediaItem> mediaItems, bool isAddcurIndex) async {
    if (PlayingController.to.fm.value && _playList.length >= 3) {
      _playList.removeRange(0, 3);
      updateQueue(_playList);
      addQueueItems(mediaItems);
    } else {
      _playList.clear();
      updateQueue(mediaItems);
      _box.put(FM_SP, true);
    }
    _currentIndex = 0;
    _playList.addAll(mediaItems);
    if (isAddcurIndex) _currentIndex++;
    if (!PlayingController.to.fm.value) PlayingController.to.fm.value = true;
    playIndex(_currentIndex);
    List<String> playList = await compute(
        setCachePlayList, RootIsolateData(rootIsolateToken, items: _playList));
    queueTitle.value = 'FM';
    _box.put(PLAY_QUEUE, playList);
  }

  @override
  Future<void> changeQueueLists(List<MediaItem> list,
      {int index = 0, bool init = false}) async {
    if (!init && PlayingController.to.fm.value) {
      PlayingController.to.fm.value = false;
      _box.put(FM_SP, false);
    }
    _currentIndex = index;
    _playList
      ..clear()
      ..addAll(list);
    bool isSui = _box.get(REPEAT_MODE, defaultValue: 'all') ==
        AudioServiceRepeatMode.none.name;
    if (isSui) {
      _playListShut
        ..clear()
        ..addAll(list)
        ..shuffle();
      await updateQueue(_playListShut);
      String songId = list[index].id;
      if (init) songId = _box.get(PLAY_ID, defaultValue: '');
      int indexBy = _playListShut.indexWhere((element) => element.id == songId);
      if (indexBy != -1) {
        _currentIndex = indexBy;
      }
    } else {
      await updateQueue(_playList);
    }
    playIndex(_currentIndex, playIt: !init);
    if (!init) {
      List<String> playList = await compute(setCachePlayList,
          RootIsolateData(rootIsolateToken, items: _playList));
      _box.put(PLAY_QUEUE, playList);
    }
  }

  @override
  Future<void> playIndex(int index, {bool playIt = true}) async {
    _currentIndex = index;
    _box.put(PLAY_INDEX, _currentIndex);
    await readySongUrl(playIt: playIt);
  }

  @override
  Future<void> readySongUrl({bool isNext = true, bool playIt = true}) async {
    try {
      if (queue.value.isEmpty) return;
      var song = queue.value[_currentIndex];
      mediaItem.add(song);

      String? url;
      // 使用预加载的URL
      if (isNext && _nextSongUrl != null) {
        url = _nextSongUrl;
        _nextSongUrl = null;
      } else if (!isNext && _previousSongUrl != null) {
        url = _previousSongUrl;
        _previousSongUrl = null;
      } else {
        url = await _preloadSongUrl(song);
        _nextSongUrl = null;
        _previousSongUrl = null;
      }

      if (url == null) return;

      await _audioPlayer.setUrl(
        url,
        initialPosition: Duration.zero,
        preload: true,
      );

      if (playIt) {
        await _audioPlayer.play();
      }

      // 开始预加载下一首和上一首
      await _preloadNextSong();
      await _preloadPreviousSong();
    } catch (e) {
      print('Audio playback error: $e');

      if (faileCount <= 2) {
        readySongUrl(isNext: isNext);
      } else {
        pause();
      }
      faileCount += 1;

      // if (isNext) {
      //   await skipToNext();
      // } else {
      //   await skipToPrevious();
      // }
    }
  }

  ///获取音乐在线URL
  Future<String?> _preloadSongUrl(MediaItem song) async {
    // 首先检查缓存
    if (song.extras?["type"] == MediaType.local.name ||
        song.extras?['type'] == MediaType.neteaseCache.name) {
      return song.extras?['url'];
    }

    try {
      final songUrl = await BujuanApi.getSongInfo([song.id]);
      return ((songUrl.data ?? [])[0].url ?? '');
    } catch (e) {
      logger.d('Failed to get song URL: $e');
      return null;
    }
  }

  ///预加载下一首歌曲
  Future<void> _preloadNextSong() async {
    // if (_nextSongUrl != null) return;

    // var nextIndex = _currentIndex + 1;
    // if (nextIndex >= queue.value.length) {
    //   nextIndex = 0;
    // }
    // var nextSong = queue.value[nextIndex];
    // _nextSongUrl = await _preloadSongUrl(nextSong);
  }

  // 预加载上一首歌曲
  Future<void> _preloadPreviousSong() async {
    // if (_previousSongUrl != null) return;

    // var prevIndex = _currentIndex - 1;
    // if (prevIndex < 0) {
    //   prevIndex = queue.value.length - 1;
    // }

    // var prevSong = queue.value[prevIndex];
    // _previousSongUrl = await _preloadSongUrl(prevSong);
  }

  ///播放下一首
  @override
  Future<void> skipToNext() async {
    _setCurrentIndex(next: true);
    faileCount = 0;
    await readySongUrl();
  }

  ///播放上一首
  @override
  Future<void> skipToPrevious() async {
    faileCount = 0;
    // await stop();
    _setCurrentIndex();
    await readySongUrl(isNext: false);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    MediaItem m = queue.value[_currentIndex];
    if (repeatMode == AudioServiceRepeatMode.none) {
      // none是随机播放
      _playListShut
        ..clear()
        ..addAll(_playList)
        ..shuffle();
      int index = _playListShut.indexWhere((element) => element.id == m.id);
      if (index != -1) _currentIndex = index;
      await updateQueue(_playListShut);
    } else {
      int index = _playList.indexWhere((element) => element.id == m.id);
      if (index != -1) _currentIndex = index;
      await updateQueue(_playList);
    }
    _audioServiceRepeatMode = repeatMode;
  }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
    await _audioPlayer.dispose();
  }

  void _setCurrentIndex({bool next = false}) {
    if (_audioServiceRepeatMode == AudioServiceRepeatMode.one) return;

    var list = _audioServiceRepeatMode == AudioServiceRepeatMode.none
        ? _playListShut
        : _playList;
    //计算新的 索引值
    _currentIndex = next ? _currentIndex + 1 : _currentIndex - 1;

    //如果超出索引范围，
    if (_currentIndex >= list.length) {
      _currentIndex = 0;
    } else if (_currentIndex < 0) {
      _currentIndex = list.length - 1;
    }
    _box.put(PLAY_INDEX, _currentIndex);
  }
}

class MediaItemMessage {
  final String id;

  final String title;

  final String? album;

  final String? artist;

  final String? genre;

  final Duration? duration;

  final Uri? artUri;

  final bool? playable;

  final String? displayTitle;

  final String? displaySubtitle;

  final String? displayDescription;

  final Map<String, dynamic>? extras;

  MediaItemMessage(
      {required this.id,
      required this.title,
      this.album,
      this.artist,
      this.genre,
      this.duration,
      this.artUri,
      this.playable,
      this.displayTitle,
      this.displaySubtitle,
      this.displayDescription,
      this.extras});

  factory MediaItemMessage.fromMap(Map<String, dynamic> raw) =>
      MediaItemMessage(
        id: raw['id'] as String,
        title: raw['title'] as String,
        album: raw['album'] as String?,
        artist: raw['artist'] as String?,
        genre: raw['genre'] as String?,
        duration: raw['duration'] != null
            ? Duration(milliseconds: raw['duration'] as int)
            : null,
        artUri:
            raw['artUri'] != null ? Uri.parse(raw['artUri'] as String) : null,
        playable: raw['playable'] as bool?,
        displayTitle: raw['displayTitle'] as String?,
        displaySubtitle: raw['displaySubtitle'] as String?,
        displayDescription: raw['displayDescription'] as String?,
        extras: castMap(raw['extras'] as Map?),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'album': album,
        'artist': artist,
        'genre': genre,
        'duration': duration?.inMilliseconds,
        'artUri': artUri?.toString(),
        'playable': playable,
        'displayTitle': displayTitle,
        'displaySubtitle': displaySubtitle,
        'displayDescription': displayDescription,
        'extras': extras,
      };
}

Map<String, dynamic>? castMap(Map? map) {
  if (map == null) return null;
  return map.cast<String, dynamic>();
}

enum MediaType { local, playlist, fm, radio, neteaseCache }
