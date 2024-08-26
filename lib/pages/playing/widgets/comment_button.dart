import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yun_music/commons/models/song_model.dart';
import 'package:yun_music/commons/res/app_themes.dart';

import '../../../commons/player/player_service.dart';
import '../../../commons/res/dimens.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/image_utils.dart';

enum PlayingOperationBarCountType {
  message,
  like,
}

class CommentButton extends StatelessWidget {
  CommentButton({super.key, required this.countType, this.onTap});

  final Function? onTap;

  final PlayingOperationBarCountType countType;

  final controller = GetInstance().putOrFind(() => CommentController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap?.call(),
      child: Obx(() {
        if (countType == PlayingOperationBarCountType.message) {
          if (controller.commentCount.value > 0) {
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
                    getCommentStrFromInt(controller.commentCount.value),
                    style: TextStyle(
                        color: AppThemes.color_217, fontSize: Dimens.font_sp9),
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
          if (controller.likeCount.value > 0) {
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
                    getCommentStrFromInt(controller.likeCount.value),
                    style: TextStyle(
                        color: AppThemes.color_217, fontSize: Dimens.font_sp9),
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
    );
  }
}

class CommentController extends GetxController {
  Song? curSong;

  final commentCount = 0.obs;
  final likeCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _updateCommentState(PlayerService.to.curPlay.value);
  }

  void _updateCommentState(Song? song) {
    if (curSong == song || song == null) {
      return;
    }
    curSong = song;
    commentCount.value = 417;
    likeCount.value = 0;
  }
}
