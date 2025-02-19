import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yun_music/video/controller/video_list_controller.dart';
import 'package:yun_music/video/models/hankan_info.dart';
import 'package:yun_music/video/models/video_list_info.dart';
import 'package:yun_music/video/widget/video_scaffold.dart';

class VideoState {
  static const String TYPE_LIST = 'type_list';
  static const String TYPE_SINGLE = 'type_single';
  static const String TYPE_OFFSET = 'type_offset';

  late String type;

  late PageController pageController;

  late VideoListController videoListController;

  late VideoScaffoldController videoController;

  VideoState() {
    videoController = VideoScaffoldController();
    videoListController =
        VideoListController(loadMoreCount: 2, preloadCount: 3);
  }
}

extension VideoControllerExt on List<VideoInfo> {
  List<VPVideoController> controllers() {
    return map((e) => VPVideoController(
        videoModel: e,
        builder: () async {
          final url = '${e.video!.play_addr!.url_list?.last}';
          return VideoPlayerController.networkUrl(Uri.parse(url));
        })).toList();
  }
}

extension HankVideoControllerExt on List<HankanInfo> {
  // List<VPVideoController> controllers() {
  //   return map((e) => VPVideoController(
  //       videoModel: e,
  //       builder: () async {
  //         // final url = '${e.play_url}';
  //         final url = '';
  //         logger.d('播放地址$url');
  //         // const url =
  //         //     "https://bakoss.hishorttv.com/vod-2a265e/506cddd3a7f371ef80065114c0db0102/6033f7e8c3324d22b9e066a842046853-a4d13fe508055ee4645de08ea234ef0a-fd.m3u8";
  //         return VideoPlayerController.networkUrl(Uri.parse(url));
  //       })).toList();
  // }
}
