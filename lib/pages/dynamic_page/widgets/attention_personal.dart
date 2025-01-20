import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';

import '../../../commons/res/app_routes.dart';
import '../models/bu_song_list_info.dart';
import '../../../commons/res/app_themes.dart';
import '../../../commons/res/dimens.dart';
import '../../../utils/adapt.dart';
import '../../../utils/common_utils.dart';
import '../../blog_page/models/blog_personal_model.dart';
import '../../blog_page/widgets/blog_header_widget.dart';
import '../../playlist_collection/widget/generral_cover_playcount.dart';

class AttentionPersonal extends StatelessWidget {
  const AttentionPersonal({super.key, required this.playLists});

  final List<BuSongListInfo?> playLists;

  @override
  Widget build(BuildContext context) {
    final itemW = (Adapt.screenW() - Dimens.gap_dp30 - Dimens.gap_dp20) / 3.0;
    final childAspectRatio =
        (itemW + Dimens.gap_dp4 + Dimens.gap_dp6 + Dimens.gap_dp32);
    return Container(
      padding: EdgeInsets.only(top: Dimens.gap_dp6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlogHeaderWidget(
            onPressed: () {},
            personal: BlogPersonalModel(),
            recomModel: null,
            showRight: false,
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: Dimens.gap_dp10,
                mainAxisSpacing: Dimens.gap_dp8,
                childAspectRatio: itemW / childAspectRatio),
            itemBuilder: (context, index) {
              final item = playLists.elementAt(index);
              return AttentionPersonalItem(itemWidth: itemW, info: item);
            },
            itemCount: playLists.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(
                left: Dimens.gap_dp15,
                right: Dimens.gap_dp15,
                top: Dimens.gap_dp10,
                bottom: Dimens.gap_dp6),
          )
        ],
      ),
    );
  }
}

class AttentionPersonalItem extends StatelessWidget {
  const AttentionPersonalItem({super.key, this.info, required this.itemWidth});

  final BuSongListInfo? info;

  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return BounceTouch(
        onPressed: () {
          Get.toNamed(RouterPath.PlayListDetailId(info!.id.toString()));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GenerralCoverPlaycount(
              imageUrl: info?.picUrl ?? '',
              playCount: info?.playCount ?? 0,
              coverSize: Size(itemWidth, itemWidth),
              coverRadius: Dimens.gap_dp8,
            ),
            SizedBox(height: Dimens.gap_dp6),
            SizedBox(
              width: itemWidth,
              child: RichText(
                  softWrap: true,
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(children: [
                    WidgetSpan(
                      // alignment: PlaceholderAlignment.middle,
                      child: Container(
                        margin: const EdgeInsets.only(right: 3),
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                width: Dimens.gap_dp1,
                                color: captionStyle().color!.withOpacity(0.2))),
                        child: Text(
                          "推荐歌单",
                          style: TextStyle(
                              color: const Color(0xFF999999),
                              fontSize: Dimens.font_sp9,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    TextSpan(
                        text: info?.name ?? "",
                        style: TextStyle(
                            fontSize: Dimens.gap_dp11,
                            color: AppThemes.body1_txt_color))
                  ])),
            )
          ],
        ));
  }
}
