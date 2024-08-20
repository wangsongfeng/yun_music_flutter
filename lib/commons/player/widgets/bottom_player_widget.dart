// ignore_for_file: unused_element

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/player/bottom_player_controller.dart';
import 'package:yun_music/commons/player/player_context.dart';
import 'package:yun_music/commons/player/player_service.dart';
import 'package:yun_music/commons/player/widgets/rotation_cover_image.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/constants.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class BottomPlayerBar extends StatefulWidget {
  const BottomPlayerBar({super.key, this.bottomPadding = 0});

  final double bottomPadding;

  @override
  State<BottomPlayerBar> createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: MediaQuery(
          data: context.mediaQuery.copyWith(
              viewInsets: context.mediaQueryViewInsets.copyWith(bottom: 0)),
          child: Obx(() {
            return _BottomContentWidget(
              listSize: context.playerService.selectedSongList.value == null
                  ? 1
                  : context.playerService.selectedSongList.value!.length,
              bottomPadding: widget.bottomPadding,
              curPlayId: 1,
            );
          })),
    );
  }
}

class _BottomContentWidget extends GetView<PlayerController> {
  _BottomContentWidget({
    super.key,
    required this.bottomPadding,
    this.curPlayId,
    required this.listSize,
  });

  final double bottomPadding;
  final int? curPlayId;
  final int listSize;

  final bool isFmPlaying = PlayerService.to.isFmPlaying.value;

  @override
  Widget build(BuildContext context) {
    Get.put(PlayerController());
    return _buildContext(context);
  }

  Widget _buildContext(BuildContext conetx) {
    final currenIndex = conetx.playerService.selectedSongList.value?.indexWhere(
        (element) => element.id == conetx.playerService.curPlayId.value);
    controller.pageController = PageController(
        initialPage:
            (currenIndex == -1 || currenIndex == null) ? 0 : currenIndex);
    return SizedBox(
      width: Adapt.screenW(),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                  color: Get.theme.cardColor.withOpacity(1.0),
                  border: Border(
                      top: BorderSide(
                        color: Get.theme.dividerColor.withOpacity(0.3),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Get.theme.dividerColor.withOpacity(1),
                        width: 0,
                      ))),
              margin: EdgeInsets.only(top: isFmPlaying ? 0 : 0),
            ),
          ),
          //内容
          Container(
            color: AppThemes.white,
            height: Dimens.gap_dp50,
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
                        physics: isFmPlaying
                            ? const NeverScrollableScrollPhysics()
                            : const BouncingScrollPhysics(),
                        onPageChanged: (page) async {
                          controller.playFromIndex(conetx, page);
                        },
                        itemBuilder: (context, index) {
                          return _buildNormWidget(
                              context.playerService.selectedSongList.value ==
                                      null
                                  ? null
                                  : context.playerService.selectedSongList
                                      .value?[index]);
                        })),
                const SizedBox(width: 12),
                InkWell(
                    onTap: () {},
                    child: Image.asset(
                      ImageUtils.getImagePath('btn_tabbar_playlist'),
                      width: Dimens.gap_dp25,
                      height: Dimens.gap_dp25,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    )),
                const SizedBox(width: 8)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNormWidget(Song? song) {
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
                  rotating: controller.isPlaying.value,
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

  Widget _buildTitle(Song? song) {
    final titleStyle = body1Style();
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: song?.name,
            style: titleStyle.copyWith(fontSize: Dimens.font_sp14),
            children: [
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(
                  text: '-',
                  style: titleStyle.copyWith(
                      fontSize: Dimens.font_sp12,
                      color: titleStyle.color?.withOpacity(0.6))),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(
                text: song?.getSongCellSubTitle(),
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
