// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/values/function.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/commons/widgets/parsed_text/match_text.dart';
import 'package:yun_music/commons/widgets/parsed_text/parsed_text.dart';
import 'package:yun_music/pages/search_all/widgets/search_result_header.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';
import 'package:yun_music/vmusic/playing_controller.dart';

import '../../search/models/search_result_wrap.dart';
import 'search_result_footer.dart';

const double SearchResultSongItemHeight = 66;

class SearchResultSong extends StatelessWidget {
  const SearchResultSong({super.key, this.song, this.searchKey});
  final SearchComplexSong? song; //单曲
  final String? searchKey;
  @override
  Widget build(BuildContext context) {
    final height = SearchResultHeaderHeight +
        (song?.more ?? false ? SearchResultFooterHeight : 0) +
        SearchResultSongItemHeight * song!.songs!.length;
    return SizedBox.fromSize(
      size: Size.fromHeight(height),
      child: Column(
        children: [
          SearchResultHeader(
            title: "单曲",
            showRightBtn: true,
            btnTitle: "播放",
            callback: () {
              final mediaItems =
                  PlayingController.to.songToMediaItem(song!.songs!);
              PlayingController.to
                  .playByIndex(0, "queueTitle", mediaItem: mediaItems);
              toPlayingPage();
            },
          ),
          Expanded(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = song!.songs?[index];
                  return SearchResultSongItem(
                    song: item!,
                    searchKey: searchKey,
                    didSelectedBack: (song) {
                      final mediaItem =
                          PlayingController.to.songToChangeMediaItem(song);
                      PlayingController.to
                          .playInsertBgMedia(mediaItem: mediaItem);
                      toPlayingPage();
                    },
                  );
                },
                itemCount: song!.songs!.length,
                itemExtent: SearchResultSongItemHeight),
          ),
          if (song?.more ?? false)
            SearchResultFooter(text: song?.moreText ?? "")
        ],
      ),
    );
  }
}

class SearchResultSongItem extends StatelessWidget {
  const SearchResultSongItem(
      {super.key,
      required this.song,
      this.searchKey,
      required this.didSelectedBack});
  final Song song;
  final String? searchKey;

  final ParamSingleCallback<Song> didSelectedBack;

  Widget _buildTitleView() {
    return Obx(() {
      return ParsedText(
        text: song.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: body1Style().copyWith(
            fontSize: Dimens.font_sp14,
            fontWeight: FontWeight.w500,
            fontFamily: W.fonts.IconFonts,
            color: PlayingController.to.mediaItem.value.id == song.id.toString()
                ? AppThemes.btn_selectd_color
                : Get.isDarkMode
                    ? Colors.white
                    : Colors.black),
        parse: [
          MatchText(
              pattern: searchKey ?? "",
              style: body1Style().copyWith(
                  fontSize: Dimens.font_sp14,
                  fontWeight: FontWeight.w500,
                  fontFamily: W.fonts.IconFonts,
                  color: PlayingController.to.mediaItem.value.id ==
                          song.id.toString()
                      ? AppThemes.btn_selectd_color
                      : AppThemes.search_parse_color),
              renderText: ({String? str, String? pattern}) {
                Map<String, String> map = <String, String>{};
                map["display"] = searchKey ?? "";
                map["value"] = searchKey ?? "";
                return map;
              })
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BounceTouch(
      onPressed: () {
        didSelectedBack.call(song);
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 20, right: 6),
        height: SearchResultSongItemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //主标题副标题 + 右边两个按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///播放中...
                Obx(() {
                  if (PlayingController.to.mediaItem.value.id ==
                      song.id.toString()) {
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (GetUtils.isNullOrBlank(song.tns) == false)
                            _buildTitleView()
                          else
                            Expanded(child: _buildTitleView()),
                          if (GetUtils.isNullOrBlank(song.tns) == false)
                            Expanded(
                              child: Text("(${song.tns!.first.toString()})",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: body1Style().copyWith(
                                    fontSize: Dimens.font_sp14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: W.fonts.IconFonts,
                                  )),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getSongTags(song),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: ParsedText(
                              text:
                                  "${song.ar.isNotEmpty ? song.ar.first.name : ""}-${song.al.name}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimens.font_sp11,
                                color: Get.isDarkMode
                                    ? AppThemes.color_156
                                    : AppThemes.color_109,
                                fontWeight: FontWeight.w500,
                                fontFamily: W.fonts.IconFonts,
                              ),
                              parse: [
                                if (GetUtils.isNullOrBlank(searchKey) == false)
                                  MatchText(
                                      pattern: searchKey ?? "",
                                      style: body1Style().copyWith(
                                        fontSize: Dimens.font_sp11,
                                        color: AppThemes.search_parse_color,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: W.fonts.IconFonts,
                                      ),
                                      renderText: (
                                          {String? str, String? pattern}) {
                                        Map<String, String> map =
                                            <String, String>{};
                                        map["display"] = searchKey ?? "";
                                        map["value"] = searchKey ?? "";
                                        return map;
                                      })
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                //右边的两个按钮

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      ImageUtils.getImagePath('cm4_btm_icn_video'),
                      width: 24,
                      color:
                          Get.isDarkMode ? Colors.white : AppThemes.color_109,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      ImageUtils.getImagePath('cb'),
                      width: 24,
                      color:
                          Get.isDarkMode ? Colors.white : AppThemes.color_109,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
