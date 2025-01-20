import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/pages/playlist_detail/playlist_detail_controller.dart';

import '../../../commons/models/song_model.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/music_loading.dart';
import '../../../services/auth_service.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../../../vmusic/playing_controller.dart';
import 'playlist_song_cells.dart';

class PlaylistSongContent extends StatelessWidget {
  const PlaylistSongContent({super.key, required this.controller, this.songs});

  final PlaylistDetailController controller;

  final List<Song>? songs;

  @override
  Widget build(BuildContext context) {
    if (songs == null) {
      return SliverToBoxAdapter(
        child: Container(
            margin: EdgeInsets.only(top: Dimens.gap_dp95),
            child: MusicLoading(
              axis: Axis.horizontal,
            )),
      );
    } else {
      final subs = controller.detail.value?.playlist.subscribers;
      return (songs!.isEmpty &&
              controller.detail.value!.playlist.creator.userId ==
                  AuthService.to.userId)
          ? _buildAddSong()
          : SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (songs!.length > index) {
                  return PlaylistSongCells(
                    song: songs!.elementAt(index),
                    index: index,
                    cellClickCallback: (item) {
                      if (controller.showCheck.value) {
                        //操作
                        List<Song>? oldList = controller.selectedSong.value;
                        if (GetUtils.isNullOrBlank(oldList) != true &&
                            oldList?.indexWhere(
                                    (element) => element.id == item.id) !=
                                -1) {
                          //已选中
                          oldList!
                              .removeWhere((element) => element.id == item.id);
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
                    controller: controller,
                  );
                } else {
                  return Container(
                    height: Dimens.gap_dp58,
                    color: Get.theme.cardColor,
                    child: Row(
                      children: [
                        SizedBox(width: Dimens.gap_dp10),
                        Expanded(
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final user = subs!.elementAt(index);
                                return buildUserAvatar(user.avatarUrl,
                                    Size(Dimens.gap_dp30, Dimens.gap_dp30));
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: Dimens.gap_dp10);
                              },
                              itemCount: subs?.length ?? 0),
                        ),
                        Text(
                          '${getPlayCountStrFromInt(controller.detail.value?.playlist.subscribedCount ?? 0)}人收藏',
                          style: TextStyle(
                              color: AppThemes.color_177,
                              fontSize: Dimens.font_sp13),
                        ),
                        Image.asset(
                          ImageUtils.getImagePath('icon_more'),
                          height: Dimens.gap_dp20,
                          color: AppThemes.color_195,
                        ),
                        SizedBox(width: Dimens.gap_dp10),
                      ],
                    ),
                  );
                }
              },
                  childCount: songs!.length +
                      (GetUtils.isNullOrBlank(subs) == true ? 0 : 1)),
            );
    }
  }

  Widget _buildAddSong() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: Dimens.gap_dp50),
        child: CupertinoButton(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp70),
              alignment: Alignment.center,
              height: Dimens.gap_dp40,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.gap_dp20)),
                  border: Border.all(color: AppThemes.app_main_light)),
              child: Text(
                '添加歌曲',
                style: TextStyle(
                    color: AppThemes.app_main_light,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimens.font_sp16),
              ),
            ),
            onPressed: () {
              // Get.toNamed(Routes.ADD_SONG, arguments: controller.playlistId);
            }),
      ),
    );
  }
}
