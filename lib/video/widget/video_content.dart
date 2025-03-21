import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../../commons/res/dimens.dart';
import '../controller/video_list_controller.dart';
import 'video_gesture.dart';

class VideoContent extends StatelessWidget {
  final VPVideoController videoController;
  final Widget video;
  final Widget rightButtonColumn;
  final Widget userInfoWidget;
  final bool isBuffering;

  final Function? onAddFavorite;
  final Function? onSingleTap;
  final Function? onCommentTap;

  const VideoContent(
      {super.key,
      required this.videoController,
      required this.video,
      required this.rightButtonColumn,
      required this.userInfoWidget,
      this.isBuffering = true,
      this.onAddFavorite,
      this.onSingleTap,
      this.onCommentTap});

  @override
  Widget build(BuildContext context) {
    // 视频播放页
    final videoContainer = Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: video,
        ),
        VideoGesture(
          onAddFavorite: onAddFavorite,
          onSingleTap: onSingleTap,
          child: Container(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Obx(() => videoController.showPauseIcon.value && !isBuffering
            ? IgnorePointer(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageUtils.getImagePath('icon_play_pause'),
                    fit: BoxFit.cover,
                    width: 52,
                    height: 62,
                  ),
                ),
              )
            : const SizedBox.shrink())
      ],
    );
    final body = Container(
        color: Colors.black,
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          child: Column(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  videoContainer,
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.bottomRight,
                    child: rightButtonColumn,
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    child: userInfoWidget,
                  ),
                  if (isBuffering)
                    Center(
                      child: LoadingAnimationWidget.progressiveDots(
                          color: Colors.white, size: Dimens.gap_dp32),
                    ),
                  // Obx(() {
                  //   if (videoController.controllerValue?.value.isBuffering ==
                  //       true) {
                  //     return Center(
                  //       child: LoadingAnimationWidget.progressiveDots(
                  //           color: Colors.white, size: Dimens.gap_dp32),
                  //     );
                  //   } else {
                  //     return const SizedBox.shrink();
                  //   }
                  // })
                ],
              )),
              GestureDetector(
                onTap: () {
                  onCommentTap?.call();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: double.infinity,
                  height: Dimens.gap_dp49,
                  padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '千言万语，汇成评论一句',
                        style: TextStyle(
                            color: Colors.white30, fontSize: Dimens.font_sp14),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
    return body;
  }
}
