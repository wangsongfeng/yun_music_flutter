// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/pages/search/models/search_result_wrap.dart';

import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/network_img_layer.dart';
import '../../../commons/widgets/parsed_text/match_text.dart';
import '../../../commons/widgets/parsed_text/parsed_text.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import 'search_result_footer.dart';
import 'search_result_header.dart';

const double SearchResultAlbumItemHeight = 68;

class SearchResultAlbum extends StatelessWidget {
  const SearchResultAlbum({super.key, this.album, this.searchKey});

  final SearchComplexAlbum? album; //歌单
  final String? searchKey;

  @override
  Widget build(BuildContext context) {
    final height = SearchResultHeaderHeight +
        (album?.more ?? false ? SearchResultFooterHeight : 0) +
        SearchResultAlbumItemHeight * album!.albums!.length;
    return SizedBox.fromSize(
        size: Size.fromHeight(height),
        child: Column(
          children: [
            const SearchResultHeader(title: "专辑", showRightBtn: false),
            Expanded(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = album!.albums?[index];
                      return SearchResultAlbumItem(
                        album: item!,
                        searchKey: searchKey,
                      );
                    },
                    itemCount: album!.albums!.length,
                    itemExtent: SearchResultAlbumItemHeight)),
            if (album?.more ?? false)
              SearchResultFooter(text: album?.moreText ?? "")
          ],
        ));
  }
}

class SearchResultAlbumItem extends StatelessWidget {
  const SearchResultAlbumItem({super.key, required this.album, this.searchKey});
  final AlbumSimple album;
  final String? searchKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SearchResultAlbumItemHeight,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset(
                    ImageUtils.getImagePath(GetPlatform.isAndroid
                        ? 'ic_cover_alb_android'
                        : 'ic_cover_alb_ios'),
                    width: SearchResultAlbumItemHeight - 16 + 6,
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: //封面
                        ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: NetworkImgLayer(
                        width: SearchResultAlbumItemHeight - 16,
                        height: SearchResultAlbumItemHeight - 16,
                        src: ImageUtils.getImageUrlFromSize(album.picUrl,
                            Size(Dimens.gap_dp40, Dimens.gap_dp40)),
                        customplaceholder: Container(
                            color: AppThemes.load_image_placeholder()),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ParsedText(
                      text: album.name,
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
                      "${album.artist?.name ?? ""},${TimeUtils.getFormat1(time: album.publishTime)}",
                      style: TextStyle(
                        fontSize: Dimens.font_sp11,
                        color: AppThemes.color_109,
                        fontWeight: FontWeight.w500,
                        fontFamily: W.fonts.IconFonts,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
