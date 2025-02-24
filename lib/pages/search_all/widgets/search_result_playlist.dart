// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/commons/widgets/parsed_text/parsed_text.dart';

import '../../../commons/models/simple_play_list_model.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/parsed_text/match_text.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../../search/models/search_result_wrap.dart';
import 'search_result_footer.dart';
import 'search_result_header.dart';

const double SearchResultPlayListItemHeight = 68;

class SearchResultPlaylist extends StatelessWidget {
  const SearchResultPlaylist({super.key, this.searchKey, this.playList});

  final SearchComplexPlayList? playList; //歌单
  final String? searchKey;

  @override
  Widget build(BuildContext context) {
    final height = SearchResultHeaderHeight +
        SearchResultFooterHeight +
        SearchResultPlayListItemHeight * playList!.playLists!.length;
    return SizedBox.fromSize(
        size: Size.fromHeight(height),
        child: Column(
          children: [
            const SearchResultHeader(title: "歌单", showRightBtn: false),
            Expanded(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = playList!.playLists?[index];
                      return SearchResultPlayListItem(
                          playList: item!, searchKey: searchKey);
                    },
                    itemCount: playList!.playLists!.length,
                    itemExtent: SearchResultPlayListItemHeight)),
            if (playList?.more ?? false)
              SearchResultFooter(text: playList?.moreText ?? "")
          ],
        ));
  }
}

class SearchResultPlayListItem extends StatelessWidget {
  const SearchResultPlayListItem(
      {super.key, required this.playList, this.searchKey});
  final SimplePlayListModel playList;
  final String? searchKey;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: SearchResultPlayListItemHeight,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //封面
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: NetworkImgLayer(
                    width: SearchResultPlayListItemHeight - 16,
                    height: SearchResultPlayListItemHeight - 16,
                    src: ImageUtils.getImageUrlFromSize(playList.getCoverUrl(),
                        Size(Dimens.gap_dp40, Dimens.gap_dp40)),
                    customplaceholder:
                        Container(color: AppThemes.load_image_placeholder()),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ParsedText(
                        text: playList.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: body1Style().copyWith(
                          fontSize: Dimens.font_sp13,
                          fontWeight: FontWeight.w500,
                          fontFamily: W.fonts.IconFonts,
                        ),
                        parse: [
                          if (GetUtils.isNullOrBlank(searchKey) == false)
                            MatchText(
                                pattern: searchKey ?? "",
                                style: body1Style().copyWith(
                                  fontSize: Dimens.font_sp13,
                                  color: AppThemes.search_parse_color,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: W.fonts.IconFonts,
                                ),
                                renderText: ({String? str, String? pattern}) {
                                  Map<String, String> map = <String, String>{};
                                  map["display"] = searchKey ?? "";
                                  map["value"] = searchKey ?? "";
                                  return map;
                                })
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        playList.getCountAndBy(),
                        style: TextStyle(
                          fontSize: Dimens.font_sp11,
                          color: AppThemes.color_150,
                          fontWeight: FontWeight.w500,
                          fontFamily: W.fonts.IconFonts,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class $ {}
