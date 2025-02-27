import 'package:flutter/material.dart';
import 'package:yun_music/commons/models/user_info_model.dart';
import 'package:yun_music/pages/search/models/search_result_wrap.dart';

import '../../../commons/res/dimens.dart';
import '../../../commons/widgets/user_avatar_page.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import 'search_result_footer.dart';
import 'search_result_header.dart';
import 'search_result_single.dart';

class SearchResultUsers extends StatelessWidget {
  const SearchResultUsers({super.key, this.user, this.searchKey});

  final SearchComplexUser? user; //歌手
  final String? searchKey;

  @override
  Widget build(BuildContext context) {
    final height = SearchResultHeaderHeight +
        (user?.more ?? false ? SearchResultFooterHeight : 0) +
        SearchResultArtistItemHeight * user!.users!.length;
    return SizedBox.fromSize(
        size: Size.fromHeight(height),
        child: Column(
          children: [
            const SearchResultHeader(title: "用户", showRightBtn: false),
            Expanded(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = user!.users?[index];
                      return SearchResultUserItem(
                          user: item!, searchKey: searchKey);
                    },
                    itemCount: user!.users!.length,
                    itemExtent: SearchResultArtistItemHeight)),
            if (user?.more ?? false)
              SearchResultFooter(text: user?.moreText ?? "")
          ],
        ));
  }
}

class SearchResultUserItem extends StatelessWidget {
  const SearchResultUserItem({super.key, required this.user, this.searchKey});
  final UserInfo user;
  final String? searchKey;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      avatar: ImageUtils.getImageUrlFromSize(user.avatarUrl,
                          Size(Dimens.gap_dp40, Dimens.gap_dp40)),
                      size: 54),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      user.nickname!,
                      style: body1Style().copyWith(
                        fontSize: Dimens.font_sp13,
                        fontWeight: FontWeight.w500,
                        fontFamily: W.fonts.IconFonts,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      ImageUtils.getImagePath(
                          user.gender == 0 ? "cm2_icn_boy" : "cm2_icn_girl"),
                      width: 12,
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
    );
  }
}
