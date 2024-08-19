import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/commons/widgets/general_song_one.dart';
import 'package:yun_music/pages/recommend/models/recom_model.dart';
import 'package:yun_music/pages/recommend/models/recom_new_song.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class ReconSlideSingleSong extends StatelessWidget {
  const ReconSlideSingleSong({
    super.key, 
    required this.blocks, 
    required this.itemHeight});

  final Blocks blocks;

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
            child: Divider(height: Dimens.gap_dp1),
          ),
          Container(
            margin: EdgeInsets.only(left: Dimens.gap_dp15, top: Dimens.gap_dp6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blocks.uiElement?.subTitle?.title ?? "",
                  style: headline1Style().copyWith(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Image.asset(
                  ImageUtils.getImagePath('ege'),
                  width: Dimens.gap_dp8,
                  height: Dimens.gap_dp8,
                )
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.91),
              itemCount: blocks.creatives?.length ?? 0,
              itemBuilder: (context, index) {
                final creativeModel = blocks.creatives!.elementAt(index);
                final resource = creativeModel.resources!.elementAt(0);
                final song = RecomNewSong.fromJson(resource.resourceExtInfo);
                return GeneralSongOne(
                    songInfo: song.buildSong(resource.action),
                    uiElementModel: resource.uiElement);
              },
            ),
          ),
        ],
      ),
    );
  }
}
