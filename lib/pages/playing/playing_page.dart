// ignore_for_file: unused_element, slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/player/player_context.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/playing/playing_controller.dart';
import 'package:yun_music/pages/playing/widgets/blur_background.dart';
import 'package:yun_music/pages/playing/widgets/comment_button.dart';
import 'package:yun_music/pages/playing/widgets/playing_album_cover.dart';
import 'package:yun_music/pages/playing/widgets/playing_nav_bar.dart';

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

                Container(
                  height: 200,
                )
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
          bottom: Dimens.gap_dp6),
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
                    color: Colors.white,
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
