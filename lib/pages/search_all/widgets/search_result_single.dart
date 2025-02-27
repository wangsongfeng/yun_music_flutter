// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/search/models/search_result_wrap.dart';
import 'package:yun_music/pages/single_category/models/single_list_wrap.dart';
import 'package:yun_music/utils/common_utils.dart';

import '../../../commons/res/app_routes.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/user_avatar_page.dart';
import '../../../utils/adapt.dart';
import '../../../utils/image_utils.dart';
import 'search_result_footer.dart';
import 'search_result_header.dart';

const double SearchResultArtistItemHeight = 68;

class SearchResultSingle extends StatelessWidget {
  const SearchResultSingle({super.key, this.artist, this.searchKey});

  final SearchComplexSingle? artist; //歌手
  final String? searchKey;

  @override
  Widget build(BuildContext context) {
    final height = SearchResultHeaderHeight +
        (artist?.more ?? false ? SearchResultFooterHeight : 0) +
        SearchResultArtistItemHeight * artist!.artists!.length;
    return SizedBox.fromSize(
        size: Size.fromHeight(height),
        child: Column(
          children: [
            const SearchResultHeader(title: "歌手", showRightBtn: false),
            Expanded(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = artist!.artists?[index];
                      return SearchResultArtistItem(
                          artist: item!, searchKey: searchKey);
                    },
                    itemCount: artist!.artists!.length,
                    itemExtent: SearchResultArtistItemHeight)),
            if (artist?.more ?? false)
              SearchResultFooter(text: artist?.moreText ?? "")
          ],
        ));
  }
}

class SearchResultArtistItem extends StatelessWidget {
  const SearchResultArtistItem(
      {super.key, required this.artist, this.searchKey});
  final Singles artist;
  final String? searchKey;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouterPath.Artist_Detail,
            arguments: {"artist_id": artist.id});
      },
      child: Container(
        height: SearchResultArtistItemHeight,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    UserAvatarPage(
                        avatar: ImageUtils.getImageUrlFromSize(
                            artist.getCoverUrl(),
                            Size(Dimens.gap_dp40, Dimens.gap_dp40)),
                        size: 54),
                    if (GetUtils.isNullOrBlank(artist.identityIconUrl) == false)
                      Positioned(
                          right: 3,
                          bottom: 3,
                          child: NetworkImgLayer(
                            width: 16,
                            height: 16,
                            src: artist.identityIconUrl,
                          ))
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artist.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: body1Style().copyWith(
                          fontSize: Dimens.font_sp13,
                          fontWeight: FontWeight.w500,
                          fontFamily: W.fonts.IconFonts,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "粉丝：",
                        style: TextStyle(
                          fontSize: Dimens.font_sp11,
                          color: AppThemes.color_109,
                          fontWeight: FontWeight.w500,
                          fontFamily: W.fonts.IconFonts,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                      border: Border.all(color: Colors.red, width: 1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                            ImageUtils.getImagePath('cm4_list_btn_icn_add'),
                            width: 15),
                        const SizedBox(width: 0),
                        const Text('关注',
                            style: TextStyle(fontSize: 12, color: Colors.red))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
