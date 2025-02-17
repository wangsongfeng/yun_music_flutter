import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yun_music/commons/res/dimens.dart';

import '../../utils/common_utils.dart';
import 'music_loading.dart';

class FooterLoading extends StatelessWidget {
  const FooterLoading({super.key, this.noMoreText = ""});

  final String noMoreText;

  @override
  Widget build(BuildContext context) {
    return CustomFooter(builder: (context, mode) {
      Widget body;
      double height;
      if (mode == LoadStatus.loading) {
        height = Dimens.gap_dp50;
        //加载状态
        body = MusicLoading(
          axis: Axis.horizontal,
        );
      } else if (mode == LoadStatus.failed) {
        height = Dimens.gap_dp50;
        //加载数据失败
        body = Text(
          "加载失败，稍后重试",
          style: body1Style().copyWith(fontSize: Dimens.font_sp14),
        );
      } else if (mode == LoadStatus.noMore) {
        //没有数据
        if (noMoreText.isNotEmpty) {
          height = Dimens.gap_dp24;
          body = Text(
            noMoreText,
            style: body1Style().copyWith(fontSize: Dimens.font_sp14),
          );
        } else {
          height = 0;
          body = const SizedBox.shrink();
        }
      } else {
        height = 0;
        body = const SizedBox.shrink();
      }
      return SizedBox(
        height: height,
        child: Center(child: body),
      );
    });
  }
}
