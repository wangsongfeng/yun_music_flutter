import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/models/song_model.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/values/function.dart';
import '../../../commons/widgets/round_checkbox.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../../../vmusic/playing_controller.dart';
import '../../day_song_recom/widgets/general_song_cell.dart';
import '../arrist_detail_list_controller.dart';

class ArtistAllSongContent extends StatelessWidget {
  const ArtistAllSongContent(
      {super.key, required this.controller, required this.songs});

  final ArristDetailListController controller;

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemBuilder: (context, index) {
          final song = songs.elementAt(index);
          return ArtistContentSongCell(
              song: song,
              index: index,
              needBgColor: false,
              cellClickCallback: (item) {
                if (controller.showCheck.value) {
                  //操作
                  List<Song>? oldList = controller.selectedSong.value;
                  if (GetUtils.isNullOrBlank(oldList) != true &&
                      oldList?.indexWhere((element) => element.id == item.id) !=
                          -1) {
                    //已选中
                    oldList!.removeWhere((element) => element.id == item.id);
                    controller.selectedSong.value = List.from(oldList);
                  } else {
                    //未选中
                    if (oldList == null) {
                      oldList = [item];
                    } else {
                      oldList.add(item);
                    }
                    controller.selectedSong.value = List.from(oldList);
                  }
                } else {
                  PlayingController.to.playByIndex(index, "queueTitle",
                      mediaItem: controller.mediaSongs.value);
                  toPlayingPage();
                }
              },
              controller: controller);
        },
        itemCount: songs.length);
  }
}

class ArtistContentSongCell extends StatelessWidget {
  ArtistContentSongCell(
      {super.key,
      required this.song,
      required this.index,
      required this.cellClickCallback,
      this.needBgColor = true,
      required this.controller});

  final Song song;
  final int index;
  final ParamSingleCallback<Song> cellClickCallback;
  final bool needBgColor;
  final ArristDetailListController controller;

  final playingController = Get.find<PlayingController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(Dimens.gap_dp56),
      child: Material(
        color: needBgColor ? Get.theme.cardColor : Colors.transparent,
        child: InkWell(
          onTap: () {
            cellClickCallback.call(song);
          },
          child: Row(
            children: [
              //number
              Container(
                width: Dimens.gap_dp40,
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp4, right: Dimens.gap_dp4),
                child: Center(
                  child: Obx(
                    () => controller.showCheck.value
                        ? RoundCheckBox(
                            Key('${song.id}}'),
                            value: GetUtils.isNullOrBlank(
                                        controller.selectedSong.value) !=
                                    true &&
                                controller.selectedSong.value?.indexWhere(
                                        (element) => element.id == song.id) !=
                                    -1,
                          )
                        : (playingController.mediaItem.value.id ==
                                song.id.toString())
                            ? Image.asset(
                                ImageUtils.getPlayingMusicTag(),
                                color: AppThemes.btn_selectd_color,
                                width: Dimens.gap_dp13,
                              )
                            : AutoSizeText(
                                '${index + 1}',
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.font_sp14,
                                    color: Get.isDarkMode
                                        ? AppThemes.white.withOpacity(0.4)
                                        : AppThemes.color_156),
                              ),
                  ),
                ),
              ),
              //song
              Expanded(
                  child: GeneralSongCell(
                song: song,
                playingController: playingController,
              )),

              if (!controller.showCheck.value)
                //最右边
                if ((song.mv ?? -1) > 0)
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: Dimens.gap_dp32,
                      child: Center(
                        child: Image.asset(
                          ImageUtils.getImagePath('video_selected'),
                          color: Get.isDarkMode
                              ? AppThemes.white.withOpacity(0.75)
                              : AppThemes.color_187,
                        ),
                      ),
                    ),
                  ),
              if (!controller.showCheck.value)
                GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    width: Dimens.gap_dp36,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        ImageUtils.getImagePath('cb'),
                        height: Dimens.gap_dp20,
                        color: Get.isDarkMode
                            ? AppThemes.white.withOpacity(0.6)
                            : AppThemes.color_187,
                      ),
                    ),
                  ),
                )
              else
                SizedBox(width: Dimens.gap_dp16)
            ],
          ),
        ),
      ),
    );
  }
}
