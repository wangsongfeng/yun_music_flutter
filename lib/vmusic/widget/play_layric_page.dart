import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import '../playing_controller.dart';

class PlayLayricPage extends StatelessWidget {
  PlayLayricPage({super.key});
  final PlayingController playingController = Get.find<PlayingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
          visible: playingController.lyricsLineModels.isNotEmpty,
          replacement: Center(
            child: Text('暂无歌词～',
                style:
                    TextStyle(fontSize: Dimens.font_sp17, color: Colors.white)),
          ),
          child: Listener(
            onPointerDown: (event) {
              playingController.onMove.value = true;
              //记录手指放下的y位置
              playingController.scrollDown.value = event.position.dy;
              playingController.canScroll.value = true;
            },
            onPointerMove: (event) {
              if (event.position.dy > playingController.scrollDown.value &&
                  playingController.lyricScrollController.offset == 0) {
                playingController.canScroll.value = false;
              } else {
                playingController.canScroll.value = true;
              }
              //手指移动暂停歌词自动滚动
              playingController.onMove.value = true;
            },
            onPointerUp: (event) {
              playingController.canScroll.value = true;
              //手指放开 延时三秒开始自动滚动（用户三秒期间可以滑动到指定位置并播放）
              Future.delayed(const Duration(milliseconds: 2500),
                  () => playingController.onMove.value = false);
            },
            child: ClickableListWheelScrollView(
              scrollController: playingController.lyricScrollController,
              onItemTapCallback: (index) {
                playingController.showLyric.value = false;
              },
              itemHeight: playingController.hasTran.value
                  ? Dimens.gap_dp100
                  : Dimens.gap_dp45,
              itemCount: playingController.lyricsLineModels.length,
              child: ListWheelScrollView.useDelegate(
                  itemExtent: playingController.hasTran.value
                      ? Dimens.gap_dp70
                      : Dimens.gap_dp40,
                  controller: playingController.lyricScrollController,
                  physics: playingController.canScroll.value
                      ? const FixedExtentScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  perspective: 0.0006,
                  onSelectedItemChanged: (index) {
                    playingController.moveLyricIndex.value = index;
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: playingController.hasTran.value
                              ? playingController.currLyricIndex.value == index
                                  ? Dimens.gap_dp70
                                  : Dimens.gap_dp75
                              : playingController.currLyricIndex.value == index
                                  ? Dimens.gap_dp50
                                  : Dimens.gap_dp40,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() => Text(
                                    playingController
                                            .lyricsLineModels[index].mainText ??
                                        '',
                                    style: TextStyle(
                                        fontSize: playingController
                                                    .currLyricIndex.value ==
                                                index
                                            ? Dimens.font_sp15
                                            : Dimens.font_sp14,
                                        fontWeight: playingController
                                                    .currLyricIndex.value ==
                                                index
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity(playingController
                                                        .currLyricIndex.value ==
                                                    index
                                                ? 0.8
                                                : playingController
                                                            .moveLyricIndex
                                                            .value ==
                                                        index
                                                    ? 0.67
                                                    : .4)),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Visibility(
                                visible: playingController.hasTran.value ||
                                    playingController.moveLyricIndex.value ==
                                        index,
                                child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0)),
                              ),
                              Visibility(
                                  visible: playingController.hasTran.value,
                                  child: Obx(() => Text(
                                      playingController.lyricsLineModels[index]
                                              .extText ??
                                          '',
                                      style: TextStyle(
                                        fontSize: Dimens.font_sp14,
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity(playingController
                                                        .currLyricIndex.value ==
                                                    index
                                                ? 0.8
                                                : .4),
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)))
                            ],
                          ),
                        );
                      },
                      childCount: playingController.lyricsLineModels.length)),
            ),
          ));
    });
  }
}
