

import 'package:flutter/material.dart';
import 'package:yun_music/commons/res/dimens.dart';
import 'package:yun_music/utils/common_utils.dart';
import 'package:yun_music/utils/image_utils.dart';

class PlayCountWidget extends StatelessWidget {
  final int playCount;

  final bool needBg;

  const PlayCountWidget({super.key, required this.playCount, this.needBg = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimens.gap_dp7, right: Dimens.gap_dp7),
      height: Dimens.gap_dp16,
      color: needBg ? Colors.black.withOpacity(0.2) : Colors.transparent,
      child: _playcount(),
    );
  }

  Widget _playcount() {
    return Row(
      children: [
        Image.asset(
          ImageUtils.getImagePath('icon_playcount'),
          width: Dimens.gap_dp8,
          height: Dimens.gap_dp8,
        ),
        SizedBox(width: Dimens.gap_dp1),
        Text(
          getPlayCountStrFromInt(playCount),
          style: TextStyle(
              color: Colors.white.withOpacity(0.9), fontSize: Dimens.font_sp10),
        )
      ],
    );
  }
}
