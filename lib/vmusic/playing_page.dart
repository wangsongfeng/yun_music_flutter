// ignore_for_file: unused_element, slash_for_doc_comments

import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/vmusic/playing_controller.dart';
import 'package:yun_music/vmusic/widget/play_layric_page.dart';
import 'package:yun_music/vmusic/widget/play_list_content.dart';
import 'package:yun_music/vmusic/widget/playing_album_cover.dart';
import 'package:yun_music/vmusic/widget/playing_nav_bar.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

import '../commons/res/app_routes.dart';
import 'widget/blur_background.dart';
import 'widget/comment_button.dart';

class PlayingPage extends GetView<PlayingController> {
  const PlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.showNeedle.value = true;
    return Scaffold(
      backgroundColor: Get.theme.cardColor,
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: getSystemUiOverlayStyle(isDark: false),
        child: Stack(
          children: [
            Obx(() {
              return BlurBackground(
                musicCoverUrl: controller.mediaItem.value.artUri.toString(),
              );
            }),
            Obx(() {
              return Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    PlayingNavBar(song: controller.mediaItem.value),
                    // SizedBox(
                    //   height: Dimens.gap_dp16,
                    // ),
                    //唱片
                    _CenterSectionPage(
                        song: controller.mediaItem.value,
                        controller: controller),
                    //音乐信息，收藏，评论
                    _PlayingOperationBarPage(song: controller.mediaItem.value),
                    //进度条
                    PlayingProgressBarPage(controller: controller),
                    //播放上一曲，下一曲
                    PlayingPauseOrPlayBarPage(controller: controller),
                    _buildBottomButton(context),
                    SizedBox(height: Adapt.bottomPadding())
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp44, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              TablerIcons.devices,
              color: Colors.grey[500],
              size: Dimens.gap_dp18,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              TablerIcons.info_square,
              color: Colors.grey[500],
              size: Dimens.gap_dp18,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              TablerIcons.dots,
              color: Colors.grey[500],
              size: Dimens.gap_dp18,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

///碟片画面
class _CenterSectionPage extends StatefulWidget {
  const _CenterSectionPage({super.key, this.song, this.controller});

  final MediaItem? song;
  final PlayingController? controller;
  @override
  State<_CenterSectionPage> createState() => __CenterSectionPageState();
}

class __CenterSectionPageState extends State<_CenterSectionPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return AnimatedCrossFade(
          firstChild: GestureDetector(
            onTap: () {
              widget.controller?.showLyric.value =
                  !widget.controller!.showLyric.value;
            },
            child: PlayingAlbumCover(music: widget.song),
          ),
          secondChild: GestureDetector(
            onTap: () {
              widget.controller?.showLyric.value =
                  !widget.controller!.showLyric.value;
            },
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimens.gap_dp16, bottom: Dimens.gap_dp16),
              color: Colors.transparent,
              width: Adapt.screenW() - Dimens.gap_dp60,
              child: PlayLayricPage(),
              // height: Adapt.screenW() - Dimens.gap_dp60,
            ),
          ),
          crossFadeState: widget.controller!.showLyric.value
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
          layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  key: bottomChildKey,
                  child: bottomChild,
                ),
                Center(
                  key: topChildKey,
                  child: topChild,
                )
              ],
            );
          },
        );
      }),
    );
  }
}

/**
 * 音乐信息，收藏，评论
 */

class _PlayingOperationBarPage extends StatelessWidget {
  const _PlayingOperationBarPage({super.key, this.song});

  final MediaItem? song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp20,
          right: Dimens.gap_dp20,
          bottom: Dimens.gap_dp24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: Dimens.gap_dp24,
                constraints: BoxConstraints(
                    maxWidth: Adapt.screenW() -
                        Dimens.gap_dp40 -
                        Dimens.gap_dp28 * 2 -
                        Dimens.gap_dp50),
                child: Text(
                  (song?.title ?? "").fixAutoLines(),
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 15,
                      color: AppThemes.color_215,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    child: Text(
                      (song?.artist ?? "").fixAutoLines(),
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: Dimens.font_sp12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(width: Dimens.gap_dp10),
          const Spacer(),
          CommentButton(
            countType: PlayingOperationBarCountType.like,
            onTaps: () {},
          ),
          Expanded(
            child: SizedBox(width: Dimens.gap_dp28),
          ),
          CommentButton(
            countType: PlayingOperationBarCountType.message,
            onTaps: () {
              Get.toNamed(RouterPath.Comment_Page,
                  arguments: PlayingController.to.mediaItem.value);
            },
          ),
        ],
      ),
    );
  }
}

/**
 * 进度条Bar
 */
class PlayingProgressBarPage extends StatelessWidget {
  const PlayingProgressBarPage({super.key, this.controller});

  final PlayingController? controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(
            left: Dimens.gap_dp20,
            right: Dimens.gap_dp20,
            bottom: Dimens.gap_dp6),
        child: Column(
          children: [
            ProgressBar(
              progress: controller!.duration.value,
              total: controller!.mediaItem.value.duration!,
              buffered: controller!.duration.value,
              progressBarColor: AppThemes.color_242,
              baseBarColor: Colors.white.withOpacity(0.3),
              bufferedBarColor: Colors.white..withOpacity(0.1),
              timeLabelLocation: TimeLabelLocation.none,
              thumbColor: Colors.white,
              barHeight: 2.0,
              thumbRadius: 4.0,
              onSeek: (value) {
                controller!.audioHandler.seek(value);
              },
            ),
            SizedBox(height: Dimens.gap_dp8),
            Row(
              children: [
                Text(
                  formatDuration(controller!.duration.value),
                  style: TextStyle(
                      fontSize: Dimens.font_sp10,
                      color: Colors.white.withOpacity(0.4)),
                ),
                const Spacer(),
                Text(
                  formatDuration(controller!.mediaItem.value.duration!),
                  style: TextStyle(
                      fontSize: Dimens.font_sp10,
                      color: Colors.white.withOpacity(0.4)),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  String hour = twoDigits(duration.inHours);
  if (hour.isNotEmpty && int.parse(hour) != 0) {
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  } else {
    if (twoDigitMinutes.isNotEmpty && int.parse(twoDigitMinutes) != 0) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}

/**
 * 下一曲，播放暂停，上一曲
 */

class PlayingPauseOrPlayBarPage extends StatelessWidget {
  const PlayingPauseOrPlayBarPage({super.key, required this.controller});

  final PlayingController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(
            top: Dimens.gap_dp12,
            left: Dimens.gap_dp20,
            right: Dimens.gap_dp20,
            bottom: Dimens.gap_dp12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                iconSize: Dimens.gap_dp38,
                onPressed: () {
                  controller.changeRepeatMode();
                },
                icon: Image.asset(
                  controller.repeartAsset.value,
                  width: Dimens.gap_dp24,
                  color: AppThemes.color_195,
                )),
            IconButton(
                iconSize: Dimens.gap_dp38,
                onPressed: () {
                  if (controller.intervalClick()) {
                    controller.audioHandler.skipToPrevious();
                  }
                },
                icon: Image.asset(
                  ImageUtils.getImagePath('cm8_play_btn_prev'),
                  width: Dimens.gap_dp24,
                  color: AppThemes.color_242,
                )),
            IconButton(
                iconSize: Dimens.gap_dp60,
                onPressed: () {
                  controller.playOrPause();
                },
                icon: Icon(
                  controller.playing.value
                      ? TablerIcons.player_pause_filled
                      : TablerIcons.player_play_filled,
                  color: AppThemes.color_242,
                  size: Dimens.gap_dp44,
                )),
            IconButton(
                iconSize: Dimens.gap_dp38,
                onPressed: () {
                  if (controller.intervalClick()) {
                    controller.audioHandler.skipToNext();
                  }
                },
                icon: Image.asset(
                  ImageUtils.getImagePath('cm8_play_btn_next'),
                  width: Dimens.gap_dp24,
                  color: AppThemes.color_242,
                )),
            IconButton(
                iconSize: Dimens.gap_dp38,
                onPressed: () {
                  _showPlaylist(context);
                },
                icon: Image.asset(
                  ImageUtils.getImagePath('cm6_icn_list'),
                  width: Dimens.gap_dp24,
                  color: AppThemes.color_195,
                ))
          ],
        ),
      );
    });
  }

  void _showPlaylist(BuildContext context) {
    HapticFeedback.lightImpact();
    showMaterialModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(Dimens.gap_dp12)),
        ),
        duration: const Duration(milliseconds: 200),
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.gap_dp12),
                    topRight: Radius.circular(Dimens.gap_dp12))),
            height: Adapt.screenH() * 0.7,
            child: const PlayListContent(),
          );
        });
  }
}
