import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/player/widgets/music_playbar_overlay.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/widgets/music_songs_event.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';
import '../../commons/res/dimens.dart';
import '../../commons/widgets/music_loading.dart';
import '../../commons/widgets/round_checkbox.dart';
import '../../commons/widgets/text_button_icon.dart';
import '../../utils/adapt.dart';
import '../../vmusic/playing_controller.dart';
import 'arrist_detail_list_controller.dart';
import 'artist_detail_controller.dart';
import 'wingets/artist_all_song_content.dart';

class ArtistSongPage extends StatelessWidget {
  const ArtistSongPage(
      {super.key,
      this.artistId,
      required this.controller,
      required this.artistDetailController});

  final String? artistId;

  final ArristDetailListController controller;
  final ArtistDetailController artistDetailController;

  @override
  Widget build(BuildContext context) {
    controller.requestArtistAllSongList(artistId ?? "");

    return Obx(() => Container(
          color: AppThemes.bg_color,
          padding: EdgeInsets.only(
              bottom: PlayingController.to.mediaItems.isNotEmpty
                  ? Adapt.tabbar_padding()
                  : Dimens.gap_dp24),
          width: double.infinity,
          height: double.infinity,
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _buildContentTopView()),
              if (controller.songs.value == null)
                const SliverToBoxAdapter(child: SizedBox.shrink())
              else
                SliverToBoxAdapter(child: _builderContentHeader(context)),
              if (controller.songs.value == null)
                SliverToBoxAdapter(
                  child: Container(
                      margin: EdgeInsets.only(top: Dimens.gap_dp56),
                      child: MusicLoading(
                        axis: Axis.horizontal,
                      )),
                )
              else
                ArtistAllSongContent(
                  controller: controller,
                  songs: controller.songs.value!.isNotEmpty
                      ? controller.songs.value!
                      : [],
                ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: Dimens.gap_dp42,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '全部演唱',
                        style: captionStyle(),
                      ),
                      Image.asset(
                        ImageUtils.getImagePath("icon_more"),
                        width: Dimens.gap_dp12,
                        color: captionStyle().color,
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ));
  }

  Widget _builderContentHeader(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (controller.showCheck.value == true) {
            return;
          }
          PlayingController.to.playByIndex(0, "queueTitle",
              mediaItem: controller.mediaSongs.value);
          toPlayingPage();
        },
        child: Container(
          height: Dimens.gap_dp38,
          padding:
              EdgeInsets.only(left: Dimens.gap_dp12, right: Dimens.gap_dp12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (controller.showCheck.value == true)
                MyTextButtonWithIcon(
                    onPressed: () {
                      if (controller.selectedSong.value?.length !=
                          controller.songs.value?.length) {
                        //未全选中
                        controller.selectedSong.value = controller.songs.value;
                      } else {
                        //已全选中
                        controller.selectedSong.value = null;
                      }
                    },
                    gap: Dimens.gap_dp8,
                    icon: RoundCheckBox(
                      const Key('all'),
                      value: controller.selectedSong.value?.length ==
                          controller.songs.value?.length,
                    ),
                    label: Text(
                      '全选',
                      style: headlineStyle().copyWith(
                        fontSize: Dimens.font_sp15,
                        fontWeight: FontWeight.w500,
                        fontFamily: W.fonts.IconFonts,
                      ),
                    ))
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: Dimens.gap_dp20,
                        height: Dimens.gap_dp20,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimens.gap_dp20 / 2.0),
                          color: Colors.red,
                        ),
                        child: Image.asset(
                          ImageUtils.getImagePath(
                              'cm8_private_cloud_play_icon'),
                          width: Dimens.gap_dp10,
                          color: Colors.white,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: Dimens.gap_dp6),
                      child: Text(
                        "播放热门 ${controller.songs.value?.length}",
                        style: body1Style().copyWith(
                            fontSize: Dimens.font_sp13,
                            color: AppThemes.body2_txt_color,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              const Expanded(child: SizedBox.shrink()),
              if (controller.showCheck.value == true)
                GestureDetector(
                  onTap: () {
                    controller.showCheck.value = !controller.showCheck.value;
                    CustomAlertDialogShow.instance.hide();
                    controller.selectedSong.value = null;
                  },
                  child: Text(
                    '完成',
                    style: TextStyle(
                      color: AppThemes.app_main_light,
                      fontSize: Dimens.font_sp15,
                      fontWeight: FontWeight.w500,
                      fontFamily: W.fonts.IconFonts,
                    ),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Dimens.gap_dp8, right: Dimens.gap_dp8),
                        child: Image.asset(
                          ImageUtils.getImagePath(
                              "cm8_artistPage_add_playlist"),
                          width: Dimens.gap_dp18,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.showCheck.value =
                            !controller.showCheck.value;
                        artistDetailController.scrollToTop();
                        CustomAlertDialogShow.instance.show(
                            context: context,
                            height: MusicSongsEventHeight,
                            child: MusicSongsEvent(
                                selectedSongs:
                                    controller.selectedSong.value ?? []));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: Dimens.gap_dp8),
                        child: Image.asset(
                            ImageUtils.getImagePath("cm8_artistPage_manage"),
                            width: Dimens.gap_dp18),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentTopView() {
    return Container(
      height: Dimens.gap_dp36,
      padding: EdgeInsets.only(left: Dimens.gap_dp14, right: Dimens.gap_dp14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: controller.songTypes
            .map((e) => GestureDetector(
                  onTap: () {
                    final index = controller.songTypes.indexOf(e);
                    controller.selectedSongType.value = index;
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: e ==
                              controller.songTypes
                                  .elementAt(controller.selectedSongType.value)
                          ? Colors.red.withOpacity(0.8)
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        e,
                        style: body1Style().copyWith(
                            fontSize: Dimens.font_sp12,
                            color: e ==
                                    controller.songTypes.elementAt(
                                        controller.selectedSongType.value)
                                ? Colors.white
                                : AppThemes.body2_txt_color,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
