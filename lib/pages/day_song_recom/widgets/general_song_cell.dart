// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/vmusic/playing_controller.dart';

class GeneralSongCell extends StatelessWidget {
  const GeneralSongCell(
      {super.key, required this.song, required this.playingController});

  final Song song;
  final PlayingController playingController;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !song.canPlay() ? 0.5 : 1.0,
      child: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    final titleStyle = body1Style().copyWith(fontSize: Dimens.font_sp16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //主标题
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return Expanded(
                  child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: song.name,
                    style: playingController.mediaItem.value.id ==
                            song.id.toString()
                        ? titleStyle.copyWith(
                            color: AppThemes.btn_selectd_color)
                        : titleStyle,
                    children: [
                      if (song.alia.isNotEmpty)
                        TextSpan(
                            text:
                                '(${song.alia.reduce((value, element) => '$value $element')})',
                            style: captionStyle().copyWith(
                                fontSize: Dimens.font_sp15,
                                color: Colors.black))
                    ]),
              ));
            }),

            const SizedBox(width: 0.1),
            // if (GetUtils.isNullOrBlank(song.reason) != true)
            //   Expanded(
            //       child: Container(
            //     height: Dimens.gap_dp15,
            //     margin: EdgeInsets.only(left: Dimens.gap_dp4),
            //     alignment: Alignment.centerLeft,
            //     child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp3),
            //       decoration: BoxDecoration(
            //           color: AppThemes.app_main.withOpacity(0.15),
            //           borderRadius:
            //               BorderRadius.all(Radius.circular(Dimens.gap_dp4))),
            //       child: Text(
            //         song.reason!,
            //         style: TextStyle(
            //             color: AppThemes.app_main, fontSize: Dimens.font_sp10),
            //       ),
            //     ),
            //   )),
          ],
        ),
        SizedBox(height: Dimens.gap_dp2),
        //副标题

        Row(
          children: [
            Row(
              children: getSongTags(song,
                  needOriginType: false,
                  needNewType: false,
                  needCopyright: false),
            ),
            Expanded(
                child: Text(
              song.getSongCellSubTitle(),
              style: captionStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        )
      ],
    );
  }
}
