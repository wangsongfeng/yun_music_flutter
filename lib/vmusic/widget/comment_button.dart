import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/res/app_themes.dart';
import 'package:yun_music/vmusic/playing_controller.dart';

import '../../commons/res/dimens.dart';
import '../../utils/common_utils.dart';
import '../../utils/image_utils.dart';

enum PlayingOperationBarCountType {
  message,
  like,
}

class CommentButton extends StatelessWidget {
  const CommentButton({super.key, required this.countType, this.onTaps});

  final Function? onTaps;

  final PlayingOperationBarCountType countType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: GestureDetector(
        onTap: () {
          onTaps?.call();
        },
        child: Obx(() {
          if (countType == PlayingOperationBarCountType.message) {
            if (PlayingController.to.selectIndex.value > 0) {
              return Stack(
                children: [
                  SizedBox(
                    width: Dimens.gap_dp28,
                    height: Dimens.gap_dp28,
                    child: Image.asset(
                      ImageUtils.getImagePath('cmt_number'),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: Dimens.gap_dp24,
                    padding: EdgeInsets.only(left: Dimens.gap_dp16),
                    alignment: Alignment.topRight,
                    child: Text(
                      getCommentStrFromInt(10),
                      style: TextStyle(
                          color: AppThemes.color_217,
                          fontSize: Dimens.font_sp9),
                    ),
                  )
                ],
              );
            } else {
              return SizedBox(
                width: Dimens.gap_dp28,
                height: Dimens.gap_dp28,
                child: Image.asset(
                  ImageUtils.getImagePath('detail_icn_cmt'),
                  color: Colors.white,
                ),
              );
            }
          } else if (countType == PlayingOperationBarCountType.like) {
            if (PlayingController.to.selectIndex.value > 0) {
              return Stack(
                children: [
                  SizedBox(
                    width: Dimens.gap_dp28,
                    height: Dimens.gap_dp28,
                    child: Image.asset(
                      ImageUtils.getImagePath('cm6_play_icn_love'),
                      width: Dimens.gap_dp24,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: Dimens.gap_dp24,
                    padding: EdgeInsets.only(left: Dimens.gap_dp16),
                    alignment: Alignment.topRight,
                    child: Text(
                      getCommentStrFromInt(10),
                      style: TextStyle(
                          color: AppThemes.color_217,
                          fontSize: Dimens.font_sp9),
                    ),
                  )
                ],
              );
            } else {
              return SizedBox(
                width: Dimens.gap_dp28,
                height: Dimens.gap_dp28,
                child: Image.asset(
                  ImageUtils.getImagePath('cm6_play_icn_love'),
                  // width: Dimens.gap_dp28,
                  color: Colors.white,
                ),
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
