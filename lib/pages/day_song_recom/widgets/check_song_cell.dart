// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/function.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/day_song_recom/widgets/general_song_cell.dart';
import 'package:yun_music/utils/image_utils.dart';
import 'package:yun_music/utils/song_check_controller.dart';
import 'package:yun_music/vmusic/playing_controller.dart';

import 'round_checkbox.dart';

class CheckSongCell extends StatelessWidget {
  const CheckSongCell(
      {super.key,
      required this.song,
      required this.checkSongController,
      required this.cellClickCallback,
      required this.playingController});

  final Song song;

  final CheckSongController checkSongController;

  final PlayingController playingController;

  final ParamSingleCallback<Song> cellClickCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(Dimens.gap_dp60),
      child: Material(
        color: Get.theme.cardColor,
        child: InkWell(
          onTap: () {
            cellClickCallback.call(song);
          },
          child: Obx(() {
            return Row(
              children: [
                if (checkSongController.showCheck.value)
                  SizedBox(width: Dimens.gap_dp10)
                else
                  SizedBox(width: Dimens.gap_dp16),

                Visibility(
                    visible: checkSongController.showCheck.value,
                    child: RoundCheckbox(
                      key: Key('${song.id}'),
                      value: GetUtils.isNullOrBlank(
                                  checkSongController.selectedSong.value) !=
                              true &&
                          checkSongController.selectedSong.value?.indexWhere(
                                  (element) => element.id == song.id) !=
                              -1,
                    )),

                if (checkSongController.showCheck.value)
                  SizedBox(width: Dimens.gap_dp10),

                //封面
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: NetworkImgLayer(
                    width: Dimens.gap_dp40,
                    height: Dimens.gap_dp40,
                    src: ImageUtils.getImageUrlFromSize(
                        song.al.picUrl, Size(Dimens.gap_dp40, Dimens.gap_dp40)),
                    customplaceholder:
                        Container(color: AppThemes.load_image_placeholder()),
                  ),
                ),

                SizedBox(width: Dimens.gap_dp10),

                ///播放中...
                Obx(() {
                  if (playingController.mediaItem.value.id ==
                          song.id.toString() &&
                      checkSongController.showCheck.value == false) {
                    return Padding(
                      padding: EdgeInsets.only(right: Dimens.gap_dp10),
                      child: Image.asset(
                        ImageUtils.getPlayingMusicTag(),
                        color: AppThemes.btn_selectd_color,
                        width: Dimens.gap_dp12,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                Expanded(
                    child: GeneralSongCell(
                  song: song,
                  playingController: playingController,
                )),

                if (!checkSongController.showCheck.value)
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
                if (!checkSongController.showCheck.value)
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
            );
          }),
        ),
      ),
    );
  }
}
