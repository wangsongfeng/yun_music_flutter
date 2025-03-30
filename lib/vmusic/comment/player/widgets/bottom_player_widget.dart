// ignore_for_file: unused_element, deprecated_member_use

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:yun_music/vmusic/comment/player/bottom_player_controller.dart';
import 'package:yun_music/vmusic/comment/player/widgets/rotation_cover_image.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';
import 'package:yun_music/vmusic/playing_controller.dart';
import 'package:yun_music/vmusic/widget/play_list_content.dart';
import 'package:yun_music/vmusic/widget/playing_nav_bar.dart';

import '../../../../commons/event/index.dart';
import '../../../../commons/event/play_bar_event.dart';

class BottomPlayerBar extends StatefulWidget {
  const BottomPlayerBar({super.key, this.bottomPadding = 0});

  final double bottomPadding;

  @override
  State<BottomPlayerBar> createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar>
    with AutomaticKeepAliveClientMixin {
  final PlayingController controller = Get.find<PlayingController>();

  late int currentIndex = 0;

  final playerController = Get.put(PlayerController());

  @override
  void initState() {
    super.initState();
    currentIndex = controller.currentIndex.value;
    controller.currentIndex.listen((value) {
      if (currentIndex != value && playerController.pageController != null) {
        playerController.pageController?.animateToPage(value,
            duration: const Duration(milliseconds: 240), curve: Curves.ease);
        currentIndex = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InkWell(
      onTap: () {
        toPlayingPage();
      },
      child: Obx(() {
        return _BottomContentWidget(
          listSize: controller.playLists.value!.length,
          bottomPadding: widget.bottomPadding,
          curPlayIndex: controller.currentIndex.value,
          playingController: controller,
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _BottomContentWidget extends GetView<PlayerController> {
  const _BottomContentWidget({
    super.key,
    required this.bottomPadding,
    this.curPlayIndex,
    required this.listSize,
    this.playingController,
  });

  final double bottomPadding;
  final int? curPlayIndex;
  final int listSize;

  final PlayingController? playingController;

  final bool isFmPlaying = false;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller.animation,
      child: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext conetxt) {
    final currenIndex = curPlayIndex;
    controller.pageController = PageController(
        initialPage:
            (currenIndex == -1 || currenIndex == null) ? 0 : currenIndex);
    return Container(
      color: conetxt.isDarkMode
          ? AppThemes.dark_tab_bg_color
          : AppThemes.tab_bg_color,
      height: double.infinity,
      width: Adapt.screenW(),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                  color: conetxt.isDarkMode
                      ? AppThemes.dark_tab_bg_color
                      : AppThemes.tab_bg_color,
                  border: Border(
                      top: BorderSide(
                        color: Get.theme.dividerColor.withOpacity(0.9),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: conetxt.isDarkMode
                            ? AppThemes.dark_line_color
                            : AppThemes.line_color,
                        width: 1,
                      ))),
              margin: EdgeInsets.only(top: isFmPlaying ? 0 : 0),
            ),
          ),
          //内容
          Container(
            color: conetxt.isDarkMode
                ? AppThemes.dark_tab_bg_color
                : AppThemes.tab_bg_color,
            child: SizedBox(
              height: Dimens.gap_dp49 - 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: isFmPlaying
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.center,
                children: [
                  //左边
                  Expanded(
                      child: PageView.builder(
                          key: UniqueKey(),
                          itemCount: listSize,
                          controller: controller.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (page) async {
                            // controller.playFromIndex(conetx, page);
                          },
                          itemBuilder: (context, index) {
                            final item =
                                playingController?.playLists.value![index];
                            return _buildNormWidget(item);
                          })),
                  const SizedBox(width: 12),
                  Obx(() {
                    return InkWell(
                        onTap: () {
                          playingController?.playOrPause();
                        },
                        child: Image.asset(
                          playingController!.playing.value
                              ? ImageUtils.getImagePath('btn_pause')
                              : ImageUtils.getImagePath('btn_play'),
                          width: Dimens.gap_dp30,
                          height: Dimens.gap_dp30,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ));
                  }),

                  const SizedBox(width: 12),

                  InkWell(
                      onTap: () {
                        _showPlaylist(conetxt);
                      },
                      child: Image.asset(
                        ImageUtils.getImagePath('play_btn_src'),
                        width: Dimens.gap_dp22,
                        height: Dimens.gap_dp22,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      )),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showPlaylist(BuildContext context) async {
    eventBus.fire(PlayBarEvent(PlayBarShowHiddenType.hidden));
    HapticFeedback.lightImpact();
    await showMaterialModalBottomSheet(
        context: context,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(Dimens.gap_dp12)),
        ),
        duration: const Duration(milliseconds: 200),
        builder: (context) {
          return SizedBox(
            height: Adapt.screenH() * 0.7,
            child: const PlayListContent(),
          );
        });
  }

  Widget _buildNormWidget(MediaItem? song) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        SizedBox.fromSize(
          size: Size(Dimens.gap_dp44, Dimens.gap_dp44),
          child: Hero(
              tag: HERO_TAG_CUR_PLAY,
              child: Obx(() {
                return RotationCoverImage(
                  rotating: playingController!.playing.value,
                  music: song,
                  pading: Dimens.gap_dp9,
                );
              })),
        ),
        const SizedBox(width: 10),
        Expanded(child: _buildTitle(song))
      ],
    );
  }

  Widget _buildTitle(MediaItem? song) {
    final titleStyle = body1Style();
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: song?.title.fixAutoLines(),
            style: titleStyle.copyWith(
                fontSize: Dimens.font_sp14,
                fontFamily: W.fonts.IconFonts,
                fontWeight: FontWeight.bold),
            children: [
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(
                  text: '-',
                  style: titleStyle.copyWith(
                      fontSize: Dimens.font_sp12,
                      color: titleStyle.color?.withOpacity(0.6))),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(
                text: (song?.artist ?? "").fixAutoLines(),
                style: titleStyle.copyWith(
                    fontSize: Dimens.font_sp12,
                    color: titleStyle.color?.withOpacity(0.6)),
              )
              // WidgetSpan(
              //     child: Container(
              //   // margin: EdgeInsets.only(top: isFmPlaying ? 0 : Dimens.gap_dp20),
              //   child: ,
              // ))
            ]),
      ),
    );
  }
}
