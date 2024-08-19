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
    return CustomFooter(
        height: Dimens.gap_dp90,
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle || mode == LoadStatus.loading) {
            //加载状态
            body = MusicLoading(
              axis: Axis.horizontal,
            );
          } else if (mode == LoadStatus.failed) {
            //加载数据失败
            body = Text(
              "加载失败，稍后重试",
              style: body1Style().copyWith(fontSize: Dimens.font_sp14),
            );
          } else {
            //没有数据
            if (noMoreText.isNotEmpty) {
              body = Text(
                noMoreText,
                style: body1Style().copyWith(fontSize: Dimens.font_sp14),
              );
            } else {
              body = const SizedBox.shrink();
            }
          }
          return SizedBox(
            height: Dimens.gap_dp50,
            child: Center(child: body),
          );
        });
  }
}
