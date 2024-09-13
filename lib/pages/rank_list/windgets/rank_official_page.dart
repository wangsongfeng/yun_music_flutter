import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/widgets/network_img_layer.dart';
import 'package:yun_music/pages/rank_list/models/ranklist_item.dart';

import '../../../commons/res/dimens.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';
import '../ranklist_contrller.dart';

class RankOfficialPage extends StatelessWidget {
  const RankOfficialPage(
      {super.key, required this.contrller, required this.items});

  final RanklistContrller contrller;

  final List<RanklistItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16,
          bottom: Dimens.gap_dp16,
          top: Dimens.gap_dp16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(children: [
            WidgetSpan(
                child: Image.asset(
              ImageUtils.getImagePath('erq'),
              width: Dimens.gap_dp20,
            )),
            WidgetSpan(child: SizedBox(width: Dimens.gap_dp5)),
            TextSpan(text: '官方榜', style: headlineStyle())
          ])),
          SizedBox(height: Dimens.gap_dp4),
          //列表
          ...items.map((e) => _buildItem(context, e)),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, RanklistItem item) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: Dimens.gap_dp8, bottom: Dimens.gap_dp8),
        padding: EdgeInsets.only(
            left: Dimens.gap_dp15,
            right: Dimens.gap_dp15,
            bottom: Dimens.gap_dp15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimens.gap_dp12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: Dimens.gap_dp12, bottom: Dimens.gap_dp8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: body1Style()
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(
                    item.updateFrequency,
                    style: Get.theme.textTheme.labelSmall!
                        .copyWith(color: Get.theme.hintColor),
                  )
                ],
              ),
            ),

            //图片+1，2，，3
            Row(
              children: [
                NetworkImgLayer(
                  width: Dimens.gap_dp100,
                  height: Dimens.gap_dp100,
                  src: item.coverImgUrl,
                  imageBuilder: (context, provider) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                          child: Image(
                            image: provider,
                          ),
                        ),
                        Positioned(
                          bottom: Dimens.gap_dp8,
                          right: Dimens.gap_dp8,
                          child: Image.asset(
                            ImageUtils.getImagePath('cm8_home_song_rcmd'),
                            width: 20,
                            height: 20,
                          ),
                        )
                      ],
                    );
                  },
                ),

                //右边的

                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.tracks
                      .map((e) => Padding(
                            padding: EdgeInsets.only(top: Dimens.gap_dp4),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimens.gap_dp16,
                                    right: Dimens.gap_dp10,
                                  ),
                                  child: Text(
                                    "${item.tracks.indexOf(e) + 1}",
                                    style: body1Style()
                                        .copyWith(fontWeight: FontWeight.w900),
                                  ),
                                ),
                                Text(
                                  e.first,
                                  style: body1Style()
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Expanded(
                                    child: Text(
                                  " - ${e.second}",
                                  style: body2Style().copyWith(
                                      fontSize: 14,
                                      color: const Color(0xFF999999)),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )),
                                Container(
                                  width: 25,
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "新",
                                    style: body2Style().copyWith(
                                        color: Colors.green, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
