import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/player/player_context.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_controller.dart';
import 'package:yun_music/vmusic/playing_controller.dart';

import '../../../commons/models/song_model.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/values/function.dart';
import '../../../commons/widgets/round_checkbox.dart';
import '../../../utils/image_utils.dart';
import '../../day_song_recom/widgets/general_song_cell.dart';

class PlaylistSongCells extends StatelessWidget {
  PlaylistSongCells(
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
  final PlaylistDetailController controller;

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
                        : context.playerService.curPlayId.value == song.id
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
                                    fontSize: Dimens.font_sp15,
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
