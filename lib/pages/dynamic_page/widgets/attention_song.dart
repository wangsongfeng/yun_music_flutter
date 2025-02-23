// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/pages/dynamic_page/widgets/attention_controller.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/values/function.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../models/bu_new_song.dart';

class AttentionSong extends StatelessWidget {
  const AttentionSong(
      {super.key, required this.controller, required this.list});

  final AttentionController controller;
  final List<BuNewSongList?> list;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        final item = list.elementAt(index);
        return AttentionSongItem(
          song: item!,
          index: index,
          cellClickCallback: (item) {},
          controller: controller,
        );
      },
      itemCount: list.length,
    );
  }
}

class AttentionSongItem extends StatelessWidget {
  const AttentionSongItem(
      {super.key,
      required this.song,
      required this.index,
      required this.cellClickCallback,
      required this.controller});

  final BuNewSongList song;
  final int index;
  final ParamSingleCallback<BuNewSongList> cellClickCallback;
  final AttentionController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.gap_dp56,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            cellClickCallback(song);
          },
          child: Row(
            children: [
              Container(
                width: Dimens.gap_dp40,
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp4, right: Dimens.gap_dp4),
                child: Center(
                  child: AutoSizeText(
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
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: song.name,
                      style: body1Style().copyWith(
                          fontSize: Dimens.font_sp15,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.gap_dp4,
                  ),
                  Text(
                    "${song.song!.artists!.isNotEmpty ? song.song!.artists!.first.name : ""} - ${song.name}",
                    style: captionStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )),
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
            ],
          ),
        ),
      ),
    );
  }
}
