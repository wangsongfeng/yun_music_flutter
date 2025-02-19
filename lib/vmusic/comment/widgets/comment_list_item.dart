import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/utils/image_utils.dart';
import 'package:yun_music/vmusic/comment/comment_controller.dart';
import 'package:yun_music/vmusic/model/comment_list.dart';

import '../../../commons/widgets/network_img_layer.dart';
import '../../../utils/common_utils.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem(
      {super.key, required this.controller, required this.item});

  final MCommentController controller;
  final CommentItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: Dimens.gap_dp16, right: Dimens.gap_dp16, top: Dimens.gap_dp8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: NetworkImgLayer(
                width: 40, height: 40, src: item.user.avatarUrl),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: Dimens.gap_dp8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.user.nickname!,
                  style: TextStyle(
                      fontSize: Dimens.font_sp13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.6)),
                ),
                Text(
                  item.timeStr!,
                  style: body1Style()
                      .copyWith(fontSize: Dimens.font_sp9, color: Colors.grey),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimens.gap_dp8, bottom: Dimens.gap_dp8),
                  child: Text(
                    item.content!,
                    style: TextStyle(
                        fontSize: Dimens.font_sp13,
                        fontWeight: FontWeight.w500,
                        fontFamily: W.fonts.Dolphin_Medium,
                        color: Colors.black.withOpacity(1.0)),
                  ),
                ),
                if (item.replyCount! > 0)
                  Padding(
                      padding: EdgeInsets.only(bottom: Dimens.gap_dp8),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              '${item.replyCount.toString()}条回复',
                              style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: Dimens.font_sp12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.blue.withOpacity(0.9)))
                                  .useSystemChineseFont(),
                            ),
                            Image.asset(ImageUtils.getImagePath('icon_more'),
                                width: Dimens.gap_dp14,
                                color: Colors.blue.withOpacity(0.9))
                          ],
                        ),
                      )),
                const Divider(
                  color: AppThemes.bg_color,
                  height: 0.5,
                )
              ],
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                item.likedCount.toString(),
                style: body1Style()
                    .copyWith(fontSize: Dimens.font_sp10, color: Colors.grey),
              ),
              Image.asset(
                ImageUtils.getImagePath("cm5_event_detail_like"),
                width: Dimens.gap_dp24,
              )
            ],
          )
        ],
      ),
    );
  }
}
