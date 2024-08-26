// ignore_for_file: unused_element, slash_for_doc_comments

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/player/player_context.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/playing/playing_controller.dart';
import 'package:yun_music/pages/playing/widgets/blur_background.dart';
import 'package:yun_music/pages/playing/widgets/comment_button.dart';
import 'package:yun_music/pages/playing/widgets/playing_album_cover.dart';
import 'package:yun_music/pages/playing/widgets/playing_nav_bar.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';

class PlayingPage extends GetView<PlayingController> {
  const PlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.showNeedle.value = true;
    return Scaffold(
      backgroundColor: Get.theme.cardColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(() {
            return BlurBackground(
              musicCoverUrl: context.curPlayRx.value?.al.picUrl,
            );
          }),
          Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Obx(() {
                  return PlayingNavBar(song: context.curPlayRx.value);
                }),
                //唱片
                Obx(() {
                  return _CenterSectionPage(song: controller.curPlaying.value);
                }),
                //音乐信息，收藏，评论
                _PlayingOperationBarPage(song: controller.curPlaying.value),
                //进度条
                const PlayingProgressBarPage(),
                //播放上一曲，下一曲
                const PlayingPauseOrPlayBarPage(),
                SizedBox(height: Adapt.bottomPadding())
              ],
            ),
          )
        ],
      ),
    );
  }
}

///碟片画面
class _CenterSectionPage extends StatefulWidget {
  const _CenterSectionPage({super.key, this.song});

  final Song? song;

  @override
  State<_CenterSectionPage> createState() => __CenterSectionPageState();
}

class __CenterSectionPageState extends State<_CenterSectionPage> {
  static bool _showLyric = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedCrossFade(
        firstChild: GestureDetector(
          onTap: () {
            setState(() {
              _showLyric = !_showLyric;
            });
          },
          child: PlayingAlbumCover(music: widget.song),
        ),
        secondChild: GestureDetector(
          onTap: () {
            setState(() {
              _showLyric = !_showLyric;
            });
          },
          child: Container(
            color: Colors.red,
            width: 300,
            height: 300,
          ),
        ),
        crossFadeState:
            _showLyric ? CrossFadeState.showSecond : CrossFadeState.showFirst,
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
      ),
    );
  }
}

/**
 * 音乐信息，收藏，评论
 */

class _PlayingOperationBarPage extends StatelessWidget {
  const _PlayingOperationBarPage({super.key, this.song});

  final Song? song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp20,
          right: Dimens.gap_dp20,
          bottom: Dimens.gap_dp20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                song?.name ?? "",
                style: const TextStyle(
                    fontSize: 17,
                    color: AppThemes.color_215,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: Dimens.gap_dp18,
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Text(
                      song?.arString() ?? "",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: Dimens.font_sp13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          CommentButton(countType: PlayingOperationBarCountType.like),
          SizedBox(width: Dimens.gap_dp24),
          CommentButton(countType: PlayingOperationBarCountType.message),
        ],
      ),
    );
  }
}

/**
 * 进度条Bar
 */
class PlayingProgressBarPage extends StatelessWidget {
  const PlayingProgressBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp20,
          right: Dimens.gap_dp20,
          bottom: Dimens.gap_dp6),
      child: Column(
        children: [
          ProgressBar(
            progress: const Duration(seconds: 0),
            total: const Duration(seconds: 0),
            buffered: const Duration(seconds: 0),
            progressBarColor: AppThemes.color_242,
            baseBarColor: Colors.white.withOpacity(0.3),
            bufferedBarColor: Colors.white..withOpacity(0.1),
            timeLabelLocation: TimeLabelLocation.none,
            thumbColor: Colors.white,
            barHeight: 2.0,
            thumbRadius: 4.0,
          ),
          SizedBox(height: Dimens.gap_dp8),
          Row(
            children: [
              Text(
                '00:00',
                style: TextStyle(
                    fontSize: Dimens.font_sp10,
                    color: Colors.white.withOpacity(0.4)),
              ),
              const Spacer(),
              Text(
                '00:00',
                style: TextStyle(
                    fontSize: Dimens.font_sp10,
                    color: Colors.white.withOpacity(0.4)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/**
 * 下一曲，播放暂停，上一曲
 */

class PlayingPauseOrPlayBarPage extends StatelessWidget {
  const PlayingPauseOrPlayBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimens.gap_dp6,
          left: Dimens.gap_dp20,
          right: Dimens.gap_dp20,
          bottom: Dimens.gap_dp12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              iconSize: Dimens.gap_dp40,
              onPressed: () {},
              icon: Image.asset(
                ImageUtils.getImagePath('cm6_icn_loop'),
                width: Dimens.gap_dp28,
                color: AppThemes.color_237,
              )),
          IconButton(
              iconSize: Dimens.gap_dp40,
              onPressed: () {},
              icon: Image.asset(
                ImageUtils.getImagePath('cm8_play_btn_prev'),
                width: Dimens.gap_dp28,
                color: AppThemes.color_237,
              )),
          IconButton(
              iconSize: Dimens.gap_dp60,
              onPressed: () {},
              icon: Image.asset(
                ImageUtils.getImagePath('cm8_play_btn_pause'),
                width: Dimens.gap_dp60,
                color: AppThemes.color_237,
              )),
          IconButton(
              iconSize: Dimens.gap_dp40,
              onPressed: () {},
              icon: Image.asset(
                ImageUtils.getImagePath('cm8_play_btn_next'),
                width: Dimens.gap_dp28,
                color: AppThemes.color_237,
              )),
          IconButton(
              iconSize: Dimens.gap_dp40,
              onPressed: () {},
              icon: Image.asset(
                ImageUtils.getImagePath('cm6_icn_list'),
                width: Dimens.gap_dp28,
                color: AppThemes.color_237,
              ))
        ],
      ),
    );
  }
}
