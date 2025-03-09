// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/function.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

double MusicSongsEventHeight = Dimens.gap_dp49 + Adapt.bottomPadding();

class MusicSongsEvent extends StatelessWidget {
  const MusicSongsEvent({super.key, required this.selectedSongs});

  final List<Song> selectedSongs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(247, 248, 248, 1.0),
      height: MusicSongsEventHeight,
      child: Padding(
        padding: EdgeInsets.only(top: Dimens.gap_dp6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomIconTextButton(
                icon: Container(
                  width: Dimens.gap_dp32,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp6,
                      right: Dimens.gap_dp6,
                      top: Dimens.gap_dp4,
                      bottom: Dimens.gap_dp2),
                  child: Image.asset(
                    ImageUtils.getImagePath("cm4_video_next_icn_prs"),
                    width: Dimens.gap_dp24,
                    color: AppThemes.dark_card_color.withOpacity(0.8),
                  ),
                ),
                text: "下一首播放",
                selected: true,
                callback: () {}),
            CustomIconTextButton(
                icon: Container(
                  width: Dimens.gap_dp32,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp4, right: Dimens.gap_dp4),
                  child: Image.asset(
                    ImageUtils.getImagePath("cm8_mlog_playlist_collection"),
                    width: Dimens.gap_dp24,
                  ),
                ),
                text: "收藏到歌单",
                selected: true,
                callback: () {}),
            CustomIconTextButton(
                icon: Container(
                  width: Dimens.gap_dp32,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp4,
                      right: Dimens.gap_dp4,
                      top: 0,
                      bottom: 0),
                  child: Image.asset(
                    ImageUtils.getImagePath("cm8_play_song_download"),
                    width: Dimens.gap_dp24,
                    color: AppThemes.dark_card_color.withOpacity(0.8),
                  ),
                ),
                text: "下载",
                selected: true,
                callback: () {}),
            CustomIconTextButton(
                icon: Container(
                  width: Dimens.gap_dp32,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp6,
                      right: Dimens.gap_dp6,
                      top: 0,
                      bottom: Dimens.gap_dp2),
                  child: Image.asset(
                    ImageUtils.getImagePath("cm8_play_song_delete"),
                    width: Dimens.gap_dp24,
                    color: AppThemes.dark_card_color.withOpacity(0.8),
                  ),
                ),
                text: "删除下载",
                selected: true,
                callback: () {})
          ],
        ),
      ),
    );
  }
}

class CustomIconTextButton extends StatelessWidget {
  const CustomIconTextButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.selected,
      required this.callback});
  final Widget icon;
  final String text;
  final bool selected;
  final ParamVoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback.call();
      },
      child: Column(
        children: [
          icon,
          SizedBox(height: Dimens.gap_dp1),
          Text(
            text,
            style: captionStyle().copyWith(fontSize: 11),
          )
        ],
      ),
    );
  }
}
