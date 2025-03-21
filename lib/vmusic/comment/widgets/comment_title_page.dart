import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/utils/adapt.dart';
import 'package:yun_music/vmusic/widget/playing_nav_bar.dart';

import '../player/widgets/rotation_cover_image.dart';
import '../../../utils/common_utils.dart';
import '../comment_controller.dart';

class CommentTitlePage extends StatelessWidget {
  const CommentTitlePage({super.key, this.controller});
  final MCommentController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Dimens.gap_dp4,
          bottom: Dimens.gap_dp4,
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16),
      color: Colors.white,
      height: Dimens.gap_dp52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RotationCoverImage(
            rotating: false,
            music: controller?.song,
            pading: Dimens.gap_dp9,
          ),
          Expanded(child: _buildTitle(controller?.song))
        ],
      ),
    );
  }

  Widget _buildTitle(MediaItem? song) {
    final titleStyle = body1Style();
    return Container(
      padding: EdgeInsets.only(left: Dimens.gap_dp6),
      alignment: Alignment.centerLeft,
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: song?.title.fixAutoLines(),
            style: TextStyle(
                fontSize: Dimens.font_sp14,
                fontWeight: FontWeight.w700,
                fontFamily: W.fonts.PingFang,
                color: Colors.black),
            children: [
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(
                  text: '-',
                  style: titleStyle.copyWith(
                      fontSize: Dimens.font_sp12,
                      color: titleStyle.color?.withOpacity(0.6))),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(
                text: (song?.artist ?? "").fixAutoLines(),
                style: titleStyle.copyWith(
                    fontSize: Dimens.font_sp12,
                    color: titleStyle.color?.withOpacity(0.6)),
              )
            ]),
      ),
    );
  }
}
