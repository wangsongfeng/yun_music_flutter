import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:yun_music/commons/values/server.dart';

import '../models/video_list_info.dart';

typedef LoadMoreVideo = Future<List<VPVideoController>> Function(
  int index,
  List<VPVideoController> list,
);

class VideoListController extends ChangeNotifier {
  VideoListController({
    this.loadMoreCount = 1,
    this.preloadCount = 3,
    this.disposeCount = 5,
  });
  //滑动到倒数第几个开始加载更多
  final int loadMoreCount;
  //预加载多少个视频
  final int preloadCount;
  //超出多少个释放视频
  final int disposeCount;

  ///提供视频的builder
  LoadMoreVideo? _videoProvider;

  //目前的视频序号
  ValueNotifier<int> index = ValueNotifier(0);
  //视频列表
  List<VPVideoController> playerList = [];
  //当前视频
  VPVideoController get currentPayer => playerList[index.value];

  //视频总数量
  int get videoCount => playerList.length;

  // init开始了
  bool isInit = false;

  void loadIndex(int target, {bool reload = false}) {
    if (!reload) {
      if (index.value == target) return;
    }

    ///播放当前视频，暂停其他的
    final int oldIndex = index.value;
    final int newIndex = target;

    //暂停之前的视频
    if (!(oldIndex == 0 && newIndex == 0)) {
      playerOfIndex(oldIndex)?.controllerValue?.seekTo(Duration.zero);
      playerOfIndex(oldIndex)?.pause();
      // logger.d('暂停$oldIndex');
    }

    //开始播放当前视频

    playerOfIndex(newIndex)?.controller.listen((VideoPlayerController? p0) {
      p0?.addListener(_didUpdateValue);
    });

    playerOfIndex(newIndex)?.play();

    logger.d('播放$newIndex');

    for (var i = 0; i < playerList.length; i++) {
      //释放 之前的视频
      if (i < newIndex - disposeCount || i > newIndex + disposeCount) {
        playerOfIndex(i)?.controllerValue?.removeListener(_didUpdateValue);
        playerOfIndex(i)?.dispose();
      } else {
        //预加载
        if (i > newIndex && i < newIndex + preloadCount) {
          playerOfIndex(i)?.init();
        }
      }
    }

    //快到最底部，需要更多视频
    if (playerList.length - newIndex <= loadMoreCount + 1) {
      _videoProvider
          ?.call(newIndex, playerList)
          .then((List<VPVideoController> list) async {
        if (list.isNotEmpty) {
          playerList.addAll(list);
          notifyListeners();
        }
      });
    }

    index.value = target;
  }

  Future<void> _didUpdateValue() async {
    notifyListeners();

    if (currentPayer.controllerValue!.value.isBuffering) {}
    if (currentPayer.controllerValue!.value.isPlaying) {}
    if (currentPayer.controllerValue!.value.isInitialized) {}

    if (currentPayer.controllerValue!.value.isInitialized) {}
  }

  //获取指定的player
  VPVideoController? playerOfIndex(int index) {
    if (index < 0 || index > playerList.length - 1) {
      return null;
    }
    return playerList[index];
  }

  void init({
    required PageController pageController,
    required List<VPVideoController> initialList,
    required LoadMoreVideo videoProvider,
    int startIndex = 0,
  }) {
    isInit = true;
    playerList.addAll(initialList);
    _videoProvider = videoProvider;
    pageController.addListener(() {
      final p = pageController.page!;
      if (p % 1 == 0) {
        loadIndex(p ~/ 1);
      }
    });
    loadIndex(startIndex, reload: true);
    notifyListeners();
  }

  @override
  void dispose() {
    for (var player in playerList) {
      player.controllerValue?.dispose();
      player.dispose();
    }
    playerList = [];
    super.dispose();
  }
}

///Future<void>来声明一个返回未来void类型的函数，
///这表示这个函数是异步的，将来会完成一些操作，但是不会返回任何具体的值。
typedef ControllerSetter<T> = Future<void> Function(T controller);
typedef ControllerGetter<T> = Future<T> Function();
typedef ControllerBuilder<T> = T Function();

abstract class TikTokVideoController<T> {
  //加载视频，在init 后，开始下载视频内容
  Future<void> init({ControllerSetter<T?>? afterInit});

  //视频销毁
  Future<void> dispose();
  //播放
  Future<void> play();
  //暂停
  Future<void> pause({bool showPause = true});
}

class VPVideoController extends TikTokVideoController<VideoPlayerController> {
  final showPauseIcon = Rx<bool>(false);

  //视频详情
  final videoInfo = Rx<VideoInfo?>(null);

  final VideoInfo videoModel;

  //当前视频播放器
  final controller = Rx<VideoPlayerController?>(null);
  VideoPlayerController? get controllerValue => controller.value;

  final ControllerGetter<VideoPlayerController> _builder;
  final ControllerGetter<VideoInfo>? _videoInfo;
  final ControllerSetter<VideoPlayerController?>? _afterInit;

  VPVideoController({
    required this.videoModel,
    required ControllerGetter<VideoPlayerController> builder,
    ControllerGetter<VideoInfo>? videoInfo,
    ControllerSetter<VideoPlayerController?>? afterInit,
  })  : _builder = builder,
        _videoInfo = videoInfo,
        _afterInit = afterInit;

  Future<void> _initController() async {
    controller.value ??= await _builder.call();
    return;
  }

  /// 阻止init的时候dispose，或者在dispose前init
  final List<Future> _actLocks = [];

  bool get isDispose => _disposeLock != null;

  bool _prepared = false;
  bool get prepared => _prepared;

  Completer<void>? _disposeLock;

  final current_isPlay = Rx<bool>(true);

  @override
  Future<void> dispose() async {
    if (!prepared) return;
    await Future.wait(_actLocks);
    _actLocks.clear();
    final Completer<void> completer = Completer();
    _actLocks.add(completer.future);
    _prepared = false;
    await controllerValue?.dispose();
    controller.value = null;
    _disposeLock = Completer();
    completer.complete();
  }

  @override
  Future<void> init({
    ControllerSetter<VideoPlayerController?>? afterInit,
  }) async {
    if (prepared) return;
    await Future.wait(_actLocks);
    _actLocks.clear();
    final completer = Completer<void>();
    _actLocks.add(completer.future);
    _requestVideoInfo();
    await _initController();
    await controllerValue
        ?.initialize()
        .timeout(
          const Duration(seconds: 3),
          onTimeout: () {},
        )
        .onError((error, stacktrace) {});
    await controllerValue?.setLooping(true);
    afterInit ??= _afterInit;
    await afterInit?.call(controllerValue);
    _prepared = true;
    completer.complete();
    if (_disposeLock != null) {
      _disposeLock?.complete();
      _disposeLock = null;
    }

    logger.d("${videoModel.desc}---init结束");
  }

  @override
  Future<void> pause({bool showPause = false}) async {
    current_isPlay.value = false;
    await Future.wait(_actLocks);
    _actLocks.clear();
    await init();
    if (!prepared) return;
    if (_disposeLock != null) {
      await _disposeLock?.future;
    }
    await controllerValue?.pause();
    showPauseIcon.value = showPause;
  }

  @override
  Future<void> play() async {
    current_isPlay.value = true;
    await Future.wait(_actLocks);
    _actLocks.clear();
    await init();
    if (!prepared) return;
    if (_disposeLock != null) {
      await _disposeLock?.future;
    }
    await controllerValue?.play();
    showPauseIcon.value = false;
    logger.d("${videoModel.desc}---开始播放");
  }

  ///请求视频详情数据
  Future<void> _requestVideoInfo() async {
    videoInfo.value = videoModel;
    if (_videoInfo != null) {}
  }
}
