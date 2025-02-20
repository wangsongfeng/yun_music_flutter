import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:yun_music/commons/widgets/music_loading.dart';
import 'package:yun_music/video/logic.dart';
import 'package:yun_music/video/state.dart';

import '../commons/res/dimens.dart';
import '../commons/res/quicker_physics.dart';
import '../utils/adapt.dart';
import '../utils/image_utils.dart';
import 'controller/video_list_controller.dart';
import 'widget/video_content.dart';
import 'widget/video_right_buttons.dart';
import 'widget/video_scaffold.dart';
import 'widget/video_user_info.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final logic = Get.find<VideoLogic>();
  final VideoState state = Get.find<VideoLogic>().videoState;

  @override
  void initState() {
    state.videoListController.addListener(_listener);
    state.videoController.addListener(() {
      if (state.videoController.value == VideoPagePosition.middle) {
        state.videoListController.currentPayer.play();
      } else {
        state.videoListController.currentPayer.pause();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    state.videoListController.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: VideoScaffold(
        controller: state.videoController,
        header: _buildHeader(),
        rightPage: Container(),
        enableGesture: true,
        page: state.videoListController.isInit == false
            ? _buildLoadingView()
            : PageView.builder(
                key: const Key('video'),
                physics: const QuickerScrollPhysics(),
                controller: state.pageController,
                scrollDirection: Axis.vertical,
                itemCount: state.videoListController.videoCount,
                itemBuilder: (context, index) {
                  final player = state.videoListController.playerOfIndex(index);
                  final rightButtons = VideoRightButtons(
                    controller: player,
                    onComment: () {},
                    onFavorite: () {},
                  );
                  // video
                  var width = Adapt.screenW();
                  var height = Adapt.screenH();
                  var fitWith = true;
                  if (player!.videoInfo.value!.video!.width! /
                          player.videoInfo.value!.video!.height! >=
                      0.75) {
                    height = width *
                        player.videoInfo.value!.video!.height! /
                        player.videoInfo.value!.video!.width!;
                    fitWith = true;
                  } else {
                    width = player.videoInfo.value!.video!.width! *
                        height /
                        player.videoInfo.value!.video!.height!;
                    fitWith = false;
                  }
                  // print(height);
                  Widget content = Container();

                  if (player.controllerValue?.value.isInitialized == false) {
                    content = Center(
                      child: _buildCover(player, fitWith, height),
                    );
                  } else {
                    content = SizedBox(
                        // height: height,
                        child: AspectRatio(
                      aspectRatio:
                          player.controllerValue?.value.aspectRatio ?? 0.75,
                      child: VideoPlayer(player.controllerValue!),
                    ));
                  }
                  return VideoContent(
                    videoController: player,
                    video: content,
                    isBuffering:
                        player.controllerValue?.value.isBuffering ?? true,
                    rightButtonColumn: rightButtons,
                    userInfoWidget: VideoUserInfo(controller: player),
                    onSingleTap: () async {
                      if (player.controllerValue != null) {
                        if (player.controllerValue!.value.isPlaying) {
                          await player.pause(showPause: true);
                        } else {
                          await player.play();
                        }
                        setState(() {});
                      }
                    },
                    onAddFavorite: () {
                      // logic.addFavorite(player.videoModel.id);
                    },
                    onCommentTap: () {
                      // logic.showComment(player.videoModel.id, true);
                    },
                  );
                  //userInfo
                }),
      ),
    );
  }

  //加载动画
  Widget _buildLoadingView() {
    return Container(
      width: Adapt.screenW(),
      height: Adapt.screenH(),
      alignment: Alignment.center,
      child: Center(
        child: Container(
          color: Colors.transparent,
          width: 100,
          height: 100,
          child: MusicLoading(
            showText: false,
            width: 26,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp4),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              Get.back();
            },
            icon: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: Colors.white,
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          IconButton(
            onPressed: () async {},
            icon: Image.asset(
              ImageUtils.getImagePath('cb'),
              color: Colors.white,
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCover(VPVideoController? player, bool fitWidth, double height) {
    return CachedNetworkImage(
      //https://dy.ttentau.top/images/
      imageUrl: "${player!.videoInfo.value!.video!.cover!.url_list!.first}",
      width: Adapt.screenW(),
      height: height,
      fit: fitWidth ? BoxFit.fitWidth : BoxFit.cover,
      placeholder: (context, url) {
        return Image.asset(
          ImageUtils.getImagePath('img_video_loading'),
          width: Adapt.screenW(),
          fit: fitWidth ? BoxFit.fitWidth : BoxFit.cover,
        );
      },
      errorWidget: (context, url, e) {
        return Image.asset(
          ImageUtils.getImagePath('img_video_loading'),
          width: Adapt.screenW(),
          fit: fitWidth ? BoxFit.fitWidth : BoxFit.cover,
        );
      },
    );
  }
}
