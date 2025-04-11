import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keframe/keframe.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/custom_touch.dart';
import 'package:yun_music/pages/found/widgets/found_appbar.dart';
import 'package:yun_music/utils/adapt.dart';
import '../../../commons/res/app_routes.dart';
import '../../../commons/widgets/network_img_layer.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../../dynamic_page/models/bu_song_list_info.dart';

class FoundPlaylist extends StatelessWidget {
  const FoundPlaylist({super.key, required this.title, required this.songList});
  final String title;
  final List<BuSongListInfo> songList;

  @override
  Widget build(BuildContext context) {
    late double itemImageW =
        (Adapt.screenW() - Dimens.gap_dp12 * 3 - Dimens.gap_dp32) / 3.0;
    late double itemHeight =
        itemImageW + Dimens.gap_dp32 + Dimens.gap_dp30 + Dimens.gap_dp40;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: Dimens.gap_dp8, bottom: 0),
      height: itemHeight,
      child: Column(
        children: [
          FoundSectionTitleView(title: title),
          Flexible(
              child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(
                left: Dimens.gap_dp16,
                right: Dimens.gap_dp16,
                top: Dimens.gap_dp8),
            itemBuilder: (context, index) {
              final item = songList[index];
              return FrameSeparateWidget(
                index: index,
                placeHolder: SizedBox(
                  width: itemImageW,
                  height: itemImageW,
                ),
                child: BounceTouch(
                  onPressed: () {
                    Get.toNamed(
                        RouterPath.PlayListDetailId(item.id.toString()));
                  },
                  child: SizedBox(
                    width: itemImageW + Dimens.gap_dp12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //图片
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Dimens.gap_dp6),
                          child: NetworkImgLayer(
                            width: itemImageW,
                            height: itemImageW,
                            src: ImageUtils.getImageUrlFromSize(
                                item.picUrl ?? "",
                                Size(itemImageW, itemImageW)),
                            imageBuilder: (context, provider) {
                              return Stack(
                                children: [
                                  Image(
                                    image: provider,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                      left: Dimens.gap_dp6,
                                      top: Dimens.gap_dp6,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageUtils.getImagePath(
                                              "cm4_cover_icn_music",
                                            ),
                                            width: Dimens.gap_dp10,
                                            height: Dimens.gap_dp12,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: Dimens.gap_dp4,
                                                right: Dimens.gap_dp7),
                                            child: Text(
                                              getPlayCountStrFromInt(
                                                  item.playCount ?? 0),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      W.fonts.MontserratM,
                                                  fontSize: Dimens.font_sp10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      )),
                                  Positioned(
                                      bottom: Dimens.gap_dp6,
                                      right: Dimens.gap_dp6,
                                      child: Image.asset(
                                        ImageUtils.getImagePath(
                                            "video_browser_play"),
                                        width: 24,
                                        color: Colors.white,
                                      ))
                                ],
                              );
                            },
                          ),
                        ),

                        SizedBox(height: Dimens.gap_dp8),
                        //标题
                        SizedBox(
                          width: itemImageW,
                          child: Text(item.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: body1Style().copyWith(
                                fontSize: Dimens.gap_dp12,
                                fontFamily: W.fonts.IconFonts,
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: songList.length,
          ))
        ],
      ),
    );
  }
}
