import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:yun_music/video/controller/video_list_controller.dart';
import 'package:yun_music/video/models/hankan_info.dart';
import 'package:yun_music/video/models/video_list_info.dart';
import 'package:yun_music/video/state.dart';

import '../api/music_api.dart';
import '../commons/event/index.dart';
import '../commons/event/play_bar_event.dart';
import 'models/avatar_info.dart';

class VideoLogic extends GetxController with WidgetsBindingObserver {
  final videoState = VideoState();

  //全部歌曲集合
  final videos = Rx<List<VideoInfo>?>(null);
  final hankvideos = Rx<List<HankanInfo>?>(null);

  void pauseVideo() {
    videoState.videoListController.currentPayer.pause();
  }

  @override
  void onReady() {
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);
    final arguments = Get.arguments;
    _initArguments(arguments);
    _getVideoLists();
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
    pauseVideo();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state != AppLifecycleState.resumed) {
      pauseVideo();
    }
  }

  Future<void> _getVideoLists({bool showLoading = false}) async {
    if (showLoading) EasyLoading.show();

    var videoList = List<VideoInfo>.empty(growable: true);
    final hishortModel = await MusicApi.requestHiShortList();
    for (var model in hishortModel!) {
      final videoInfo = VideoInfo();
      final avatarUrlsInfo = AvatarUrlsInfo(
          100,
          100,
          [
            "https://iknow-pic.cdn.bcebos.com/96dda144ad345982c29d3c0f1ef431adcbef841c"
          ],
          "uri");
      videoInfo.avatar = AvatarInfo(
          avatarUrlsInfo, avatarUrlsInfo, "city", "uid", model.vidName);
      videoInfo.desc = model.vidDescribe;
      final statistics = Statistics(
          digg_count: model.likeNums,
          comment_count: 656,
          collect_count: model.collectNums,
          share_count: 145);
      videoInfo.statistics = statistics;

      final music = Music();
      final coverMedium = CoverMedium(url_list: [
        "https://iknow-pic.cdn.bcebos.com/96dda144ad345982c29d3c0f1ef431adcbef841c"
      ]);
      music.cover_medium = coverMedium;
      music.title = model.vidName;
      videoInfo.music = music;

      final jsonVideo = Video();
      jsonVideo.width = 720;
      jsonVideo.height = 1280;
      final playAddr = PlayAddr(url_list: [model.firstPlayUrl!]);
      jsonVideo.play_addr = playAddr;
      final videoCover = CoverMedium(url_list: [model.coverUrl!]);
      jsonVideo.cover = videoCover;
      videoInfo.video = jsonVideo;
      videoList.add(videoInfo);
    }
    videos.value = videoList;

    //https://dy.ttentau.top/images/

    // final detailModel = await MusicApi.getVideoLists();
    // var videoLists = detailModel?.sublist(0, 30);
    // final userList = await MusicApi.getUsersLists();
    // videoLists = videoLists?.map((e) {
    //   e.avatar =
    //       userList?.firstWhere((u) => u.uid == e.author_user_id.toString());
    //   return e;
    // }).toList();
    // videos.value = detailModel?.sublist(0, 30);
    EasyLoading.dismiss();
    _initVideoController(videos.value!, 0);
  }

  void _initArguments(dynamic arguments) {
    videoState.pageController = PageController(initialPage: 0);
  }

  //初始化播放器
  void _initVideoController(List<VideoInfo> data, index) {
    videoState.videoListController.init(
        pageController: videoState.pageController,
        startIndex: index,
        initialList: data.controllers(),
        videoProvider: (int index, List<VPVideoController> list) async {
          return List.empty();
        });
  }
}
